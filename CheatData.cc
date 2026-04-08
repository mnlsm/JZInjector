#include "pch.h"
#include "CheatData.h"

PersonData::PersonData() {
    init();
}

void PersonData::init() {
    jyqxz_person_id() = -1;
}

std::vector<int>& PersonData::jyqxz_person_wugongs() { 
    auto& wugongs = std::get<5>(*this);
    while (wugongs.size() < WUGONG_COUNT) {
        wugongs.push_back(0x00);
    }
    return wugongs;
}

std::vector<int> PersonData::jyqxz_person_sort_wugongs() {
    std::vector<int> result;
    auto& wugongs = std::get<5>(*this);
    for (int w : wugongs) {
        if (w != 0x00) {
            result.push_back(w);
        }
    }
    while (result.size() < WUGONG_COUNT) {
        result.push_back(0x00);
    }
    return result;
}


std::vector<std::pair<std::wstring, int>> PersonData::GetPersons() {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"主角", 0x00));
    result.push_back(std::make_pair<std::wstring, int>(L"祖千秋", 0x58));
    result.push_back(std::make_pair<std::wstring, int>(L"人厨子", 0x59));
    result.push_back(std::make_pair<std::wstring, int>(L"胡青牛", 0x10));
    result.push_back(std::make_pair<std::wstring, int>(L"王难姑", 0x11));
    result.push_back(std::make_pair<std::wstring, int>(L"程灵素", 0x02));
    result.push_back(std::make_pair<std::wstring, int>(L"程英", 0x3F));
    result.push_back(std::make_pair<std::wstring, int>(L"黄蓉", 0x38));
    result.push_back(std::make_pair<std::wstring, int>(L"李沅芷", 0x5C));
    result.push_back(std::make_pair<std::wstring, int>(L"钟灵", 0x5A));
    result.push_back(std::make_pair<std::wstring, int>(L"霍青桐", 0x4A));
    result.push_back(std::make_pair<std::wstring, int>(L"温青青", 0x5B));
    result.push_back(std::make_pair<std::wstring, int>(L"萧中慧", 0x4D));
    result.push_back(std::make_pair<std::wstring, int>(L"梅超风", 0x4E));
    result.push_back(std::make_pair<std::wstring, int>(L"小龙女", 0x3B));
    result.push_back(std::make_pair<std::wstring, int>(L"王语嫣", 0x4C));
    result.push_back(std::make_pair<std::wstring, int>(L"朱九真", 0x51));
    result.push_back(std::make_pair<std::wstring, int>(L"苏荃", 0x57));
    result.push_back(std::make_pair<std::wstring, int>(L"阿珂", 0x56));
    result.push_back(std::make_pair<std::wstring, int>(L"任盈盈", 0x49));


    result.push_back(std::make_pair<std::wstring, int>(L"胡斐", 0x01));
    result.push_back(std::make_pair<std::wstring, int>(L"狄云", 0x25));
    result.push_back(std::make_pair<std::wstring, int>(L"石破天", 0x26));
    result.push_back(std::make_pair<std::wstring, int>(L"田伯光", 0x1D));
    result.push_back(std::make_pair<std::wstring, int>(L"杨过", 0x3A));
    result.push_back(std::make_pair<std::wstring, int>(L"令狐冲", 0x23));
    result.push_back(std::make_pair<std::wstring, int>(L"慕容复", 0x33));

    result.push_back(std::make_pair<std::wstring, int>(L"老顽童", 0x40));
    return result;
}



//----------------------------------------------------------------------------------------------------

MiscData::MiscData() {
    init();
}

std::vector<std::pair<std::wstring, int>> MiscData::GetXiuLian(int code) {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"      ", -1));
    result.push_back(std::make_pair<std::wstring, int>(L"食神秘籍", 0xDC));
    result.push_back(std::make_pair<std::wstring, int>(L"酒神秘籍", 0xDD));
    result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医术", 0xBD));
    result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 0xC1));
    result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 0xEB));
    result.push_back(std::make_pair<std::wstring, int>(L"易筋经", 0x55));
    result.push_back(std::make_pair<std::wstring, int>(L"洗遂经", 0x010C));
    result.push_back(std::make_pair<std::wstring, int>(L"吸星大法", 0x41));
    result.push_back(std::make_pair<std::wstring, int>(L"袈裟伏魔功", 0x0107));
    result.push_back(std::make_pair<std::wstring, int>(L"万花剑法", 0x83));
    result.push_back(std::make_pair<std::wstring, int>(L"九阳真经", 0x53));
    result.push_back(std::make_pair<std::wstring, int>(L"九阴真经", 0x54));
    result.push_back(std::make_pair<std::wstring, int>(L"降龙十八掌", 0x56));
    result.push_back(std::make_pair<std::wstring, int>(L"独孤九剑", 0x72));
    result.push_back(std::make_pair<std::wstring, int>(L"幻阴指", 0x5E));
    result.push_back(std::make_pair<std::wstring, int>(L"燃木刀法", 0x89));


    bool found = false;
    for (auto& item : result) {
        if (item.second == code) {
            found = true;
            break;
        }
    }
    if (!found) {
        wchar_t szBuf[32] = { 0 };
        swprintf_s(szBuf, 32, L"%04X", code);
        result.push_back(std::make_pair<std::wstring, int>(std::wstring(szBuf), std::move(code)));
    }
    return result;
}

std::vector<std::pair<std::wstring, int>> MiscData::GetWuGong(int code) {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"      ", 0x0000));
    result.push_back(std::make_pair<std::wstring, int>(L"百战天龙", 0x7A));
    result.push_back(std::make_pair<std::wstring, int>(L"黑极浮图", 0x72));
    result.push_back(std::make_pair<std::wstring, int>(L"乾坤太极", 0x78));
    result.push_back(std::make_pair<std::wstring, int>(L"烈焰天刀", 0x7D));
    result.push_back(std::make_pair<std::wstring, int>(L"狂风绝技", 0x7E));
    result.push_back(std::make_pair<std::wstring, int>(L"瑜伽密乘", 0x76));
    result.push_back(std::make_pair<std::wstring, int>(L"逆时行舟", 0x75));
    result.push_back(std::make_pair<std::wstring, int>(L"妙手空空", 0x73));
    result.push_back(std::make_pair<std::wstring, int>(L"重阳尊决", 0x77));
    result.push_back(std::make_pair<std::wstring, int>(L"地狱葵花", 0x74));
    result.push_back(std::make_pair<std::wstring, int>(L"皇玺剑印", 0x7C));
    result.push_back(std::make_pair<std::wstring, int>(L"天下无狗", 0x7F));
    result.push_back(std::make_pair<std::wstring, int>(L"武中无相", 0x79));
    bool found = false;
    for (auto& item : result) {
        if (item.second == code) {
            found = true;
            break;
        }
    }
    if (!found) {
        wchar_t szBuf[32] = { 0 };
        swprintf_s(szBuf, 32, L"%04X", code);
        result.push_back(std::make_pair<std::wstring, int>(std::wstring(szBuf), std::move(code)));
    }
    return result;
}


void MiscData::read_config_file(const char* config_filepath) {
    if (!::PathFileExistsA(config_filepath)) {
        write_config_file(config_filepath);
    } else {
        jyqxz_trace_log() = GetPrivateProfileIntA("baoxi", "jyqxz_trace_log", 0, config_filepath);
        jyqxz_baoxi_dengji() = GetPrivateProfileIntA("baoxi", "jyqxz_baoxi_dengji", 0, config_filepath);
        jyqxz_baoxi_wugong() = GetPrivateProfileIntA("baoxi", "jyqxz_baoxi_wugong", 0, config_filepath);
        jyqxz_baoxi_maxvalue() = GetPrivateProfileIntA("baoxi", "jyqxz_baoxi_maxvalue", 0, config_filepath);
        jyqxz_adjust_wupin() = GetPrivateProfileIntA("wupin", "jyqxz_adjust_wupin", 0, config_filepath);;
    }
}

void MiscData::write_config_file(const char* config_filepath) {
    if (::PathFileExistsA(config_filepath)) {
        ::DeleteFileA(config_filepath);
    }
    WritePrivateProfileStringA("baoxi", "jyqxz_trace_log",
        std::to_string(jyqxz_trace_log()).c_str(), config_filepath);
    WritePrivateProfileStringA("baoxi", "jyqxz_baoxi_dengji",
        std::to_string(jyqxz_baoxi_dengji()).c_str(), config_filepath);
    WritePrivateProfileStringA("baoxi", "jyqxz_baoxi_wugong",
        std::to_string(jyqxz_baoxi_wugong()).c_str(), config_filepath);
    WritePrivateProfileStringA("baoxi", "jyqxz_baoxi_maxvalue",
        std::to_string(jyqxz_baoxi_maxvalue()).c_str(), config_filepath);
    WritePrivateProfileStringA("wupin", "jyqxz_adjust_wupin",
        std::to_string(jyqxz_adjust_wupin()).c_str(), config_filepath);
}

void MiscData::init() {
    jyqxz_trace_log() = 1;
    jyqxz_baoxi_dengji() = 2;
    jyqxz_baoxi_wugong() = 0;
    jyqxz_baoxi_maxvalue() = 1;

    jyqxz_adjust_wupin() = 0;
}