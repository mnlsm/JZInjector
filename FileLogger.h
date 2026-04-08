// FileLogger.h
#ifndef FILELOGGER_H
#define FILELOGGER_H

#include <string>
#include <fstream>
#include <mutex>
#include <chrono>
#include <sstream>
#include <iomanip>

#include "framework.h"

class FileLogger {
public:
    enum class LogLevel {
        DEB,
        INFO,
        WARNING,
        ERR,
        FATALED
    };

    // 获取单例实例
    static FileLogger& getInstance() {
        static FileLogger instance;
        return instance;
    }

    // 初始化日志系统
    bool init(const std::string& filename,
        LogLevel minLevel = LogLevel::DEB,
        bool append = true);

    // 日志写入接口
    void debug(const std::string& message);
    void info(const std::string& message);
    void warning(const std::string& message);
    void error(const std::string& message);
    void fataled(const std::string& message);

    // 设置日志级别
    void setLogLevel(LogLevel level);

    // 关闭日志
    void shutdown();

    // 禁止拷贝
    FileLogger(const FileLogger&) = delete;
    FileLogger& operator=(const FileLogger&) = delete;

private:
    friend class LogStream;
    FileLogger() = default;
    ~FileLogger();

    // 内部写入方法
    void write(LogLevel level, const std::string& message);

    // 获取当前时间字符串
    std::string getCurrentTime();

    // 日志级别转字符串
    std::string levelToString(LogLevel level);

    std::ofstream logFile_;
    std::recursive_mutex  mutex_;
    LogLevel minLevel_ = LogLevel::DEB;
    std::string filename_;
    bool initialized_ = false;
};

class LogStream {
public:
    LogStream(FileLogger& logger, FileLogger::LogLevel level)
        : logger_(logger), level_(level) {}

    ~LogStream() {
        logger_.write(level_, stream_.str());
    }

    template<typename T>
    LogStream& operator<<(const T& value) {
        stream_ << value;
        return *this;
    }

private:
    std::ostringstream stream_;
    FileLogger& logger_;
    FileLogger::LogLevel level_;
};

class LogIgnore {
public:
    LogIgnore() = default;
    ~LogIgnore() = default;
public:
    template<typename T>
    LogIgnore& operator<<(const T& value) {
        return *this;
    }
};



// 宏定义，方便使用
#ifdef DEBUGLOG
#define LOG_DEBUG()    LogStream(FileLogger::getInstance(), FileLogger::LogLevel::DEBUG)
#define LOG_INFO()     LogStream(FileLogger::getInstance(), FileLogger::LogLevel::INFO)
#define LOG_WARNING()  LogStream(FileLogger::getInstance(), FileLogger::LogLevel::WARNING)
#define LOG_ERROR()    LogStream(FileLogger::getInstance(), FileLogger::LogLevel::ERR)
#define LOG_FATAL()    LogStream(FileLogger::getInstance(), FileLogger::LogLevel::FATALED)

#else
#define LOG_DEBUG()    LogIgnore()
#define LOG_INFO()     LogIgnore()
#define LOG_WARNING()  LogIgnore()
#define LOG_ERROR()    LogIgnore()
#define LOG_FATAL()    LogIgnore()
#endif


#endif // FILELOGGER_H