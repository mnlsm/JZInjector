// FileLogger.cpp
#include "pch.h"
#include "FileLogger.h"
#include <iostream>
//#include <filesystem>

#ifdef _WIN32
#include <direct.h>
#define MKDIR(path) _mkdir(path)
#else
#include <sys/stat.h>
#define MKDIR(path) mkdir(path, 0755)
#endif


FileLogger::~FileLogger() {
    shutdown();
}

bool FileLogger::init(const std::string& filename,
    LogLevel minLevel,
    bool append) {
    std::lock_guard<std::recursive_mutex> lock(mutex_);

    if (initialized_) {
        return true;
    }

    filename_ = filename;
    minLevel_ = minLevel;

    /*
    // 创建目录（如果不存在）
    try {
        size_t pos = filename.find_last_of("/\\");
        if (pos != std::string::npos) {
            std::string dir = filename.substr(0, pos);
            if (!dir.empty()) {
                std::filesystem::create_directories(dir);
            }
        }
    }
    catch (...) {
        std::cerr << "Failed to create log directory" << std::endl;
    }
    */

    // 打开文件
    std::ios_base::openmode mode = std::ios_base::out;
    if (append) {
        mode |= std::ios_base::app;
    }

    logFile_.open(filename, mode);

    if (!logFile_.is_open()) {
        std::cerr << "Failed to open log file: " << filename << std::endl;
        return false;
    }

    initialized_ = true;

    // 写入初始化信息
    //write(LogLevel::INFO, "Log system initialized");

    return true;
}

void FileLogger::write(LogLevel level, const std::string& message) {
    if (level < minLevel_ || !initialized_ || !logFile_.is_open()) {
        return;
    }

    std::lock_guard<std::recursive_mutex> lock(mutex_);

    std::string timeStr = getCurrentTime();
    std::string levelStr = levelToString(level);

    logFile_ << "[" << timeStr << "] "
        << "[" << levelStr << "] "
        << message << std::endl;

    // 立即刷新，确保日志不丢失
    logFile_.flush();
}

void FileLogger::debug(const std::string& message) {
    write(LogLevel::DEB, message);
}

void FileLogger::info(const std::string& message) {
    write(LogLevel::INFO, message);
}

void FileLogger::warning(const std::string& message) {
    write(LogLevel::WARNING, message);
}

void FileLogger::error(const std::string& message) {
    write(LogLevel::ERR, message);
}

void FileLogger::fataled(const std::string& message) {
    write(LogLevel::FATALED, message);
}

void FileLogger::setLogLevel(LogLevel level) {
    std::lock_guard<std::recursive_mutex> lock(mutex_);
    minLevel_ = level;
}

void FileLogger::shutdown() {
    std::lock_guard<std::recursive_mutex> lock(mutex_);

    if (initialized_) {
        write(LogLevel::INFO, "Log system shutdown");
        if (logFile_.is_open()) {
            logFile_.close();
        }
        initialized_ = false;
    }
}

std::string FileLogger::getCurrentTime() {
    auto now = std::chrono::system_clock::now();
    auto time = std::chrono::system_clock::to_time_t(now);
    auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(
        now.time_since_epoch()
        ) % 1000;

    std::stringstream ss;

    // 使用 localtime_s 或 localtime_r
#ifdef _WIN32
    struct tm timeInfo;
    localtime_s(&timeInfo, &time);
    ss << std::put_time(&timeInfo, "%Y-%m-%d %H:%M:%S");
#else
    struct tm timeInfo;
    localtime_r(&time, &timeInfo);
    char buffer[80];
    strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", &timeInfo);
    ss << buffer;
#endif

    ss << "." << std::setfill('0') << std::setw(3) << ms.count();

    return ss.str();
}

std::string FileLogger::levelToString(LogLevel level) {
    switch (level) {
    case LogLevel::DEB:   return "DEBUG";
    case LogLevel::INFO:    return "INFO";
    case LogLevel::WARNING: return "WARN";
    case LogLevel::ERR:   return "ERROR";
    case LogLevel::FATALED:   return "FATAL";
    default:                return "UNKNOWN";
    }
}