#include "pch.h"
#include "CheatData.h"


bool EnvData::is_valid_status() {
    return (this->Status == STATUS_GAME_MMAP 
        || this->Status == STATUS_GAME_SMAP);
}

bool EnvData::is_valid_banben() {
    return (this->BanBen <= BANBEN_CL1028
        && this->BanBen >= BANBEN_YB);
}


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


std::vector<std::pair<std::wstring, int>> PersonData::GetPersons(int banben, 
            bool filter_duiyou) {
    std::vector<std::pair<std::wstring, int>> result;
    if (banben == EnvData::BANBEN_YB) {
        result = PersonData::GetPersons_YB();
    } else if (banben == EnvData::BANBEN_CL) {
        result = PersonData::GetPersons_CL();
    } else if (banben == EnvData::BANBEN_ZZJH) {
        result = PersonData::GetPersons_ZZJH();
    } else if (banben == EnvData::BANBEN_XMB) {
        result = PersonData::GetPersons_XMB();
    } else if (banben == EnvData::BANBEN_TSJ) {
        result = PersonData::GetPersons_TSJ();
    } else if (banben == EnvData::BANBEN_CL1028) {
        result = PersonData::GetPersons_CL1028();
    }
    if (filter_duiyou) {
        std::set<int> duiyous;
        duiyous.insert(jyqxz_person_duiyous().begin(), jyqxz_person_duiyous().end());
        for (int i = result.size() - 1; i >= 0; i--) {
            if (result[i].second == 0) continue;
            if (duiyous.find(result[i].second) == duiyous.cend()) {
                result.erase(result.begin() + i);
            }
        }
    }
    return result;
}


std::vector<int>& PersonData::jyqxz_person_duiyous() {
    static std::vector<int> s_duiyous;
    return s_duiyous;
}


//----------------------------------------------------------------------------------------------------

MiscData::MiscData() {
    init();
}

std::vector<std::pair<std::wstring, int>> MiscData::GetXiuLian(int banben, int code) {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"      ", -1));
    if (banben == EnvData::BANBEN_YB) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 91));
        result.push_back(std::make_pair<std::wstring, int>(L"太玄经", 60));
        result.push_back(std::make_pair<std::wstring, int>(L"凌波微步", 47));
        result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医书", 50));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 53));
        result.push_back(std::make_pair<std::wstring, int>(L"独孤九剑", 79));
        result.push_back(std::make_pair<std::wstring, int>(L"九阳真经", 95));
        result.push_back(std::make_pair<std::wstring, int>(L"葵花宝典", 93));
    } else if (banben == EnvData::BANBEN_CL) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 235));
        result.push_back(std::make_pair<std::wstring, int>(L"食神秘籍", 220));
        result.push_back(std::make_pair<std::wstring, int>(L"酒神秘籍", 221));
        result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医术", 189));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 193));
    } else if (banben == EnvData::BANBEN_ZZJH) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 102));
        result.push_back(std::make_pair<std::wstring, int>(L"太玄神功", 114));
        result.push_back(std::make_pair<std::wstring, int>(L"子午针灸经", 42));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 46));
        result.push_back(std::make_pair<std::wstring, int>(L"凌波微步", 62));
        result.push_back(std::make_pair<std::wstring, int>(L"神照经", 47));
        result.push_back(std::make_pair<std::wstring, int>(L"易筋经", 60));
        result.push_back(std::make_pair<std::wstring, int>(L"武穆遗书", 69));
    } else if (banben == EnvData::BANBEN_XMB) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 91));
        result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医书", 50));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 53));
        result.push_back(std::make_pair<std::wstring, int>(L"独孤九剑", 79));
        result.push_back(std::make_pair<std::wstring, int>(L"九阳真经", 95));
        result.push_back(std::make_pair<std::wstring, int>(L"葵花宝典", 93));
    } else if (banben == EnvData::BANBEN_TSJ) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 235));
        result.push_back(std::make_pair<std::wstring, int>(L"食神秘籍", 220));
        result.push_back(std::make_pair<std::wstring, int>(L"酒神秘籍", 221));
        result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医术", 189));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 193));
        result.push_back(std::make_pair<std::wstring, int>(L"独孤九剑", 316));
        result.push_back(std::make_pair<std::wstring, int>(L"打狗棒法", 403));
    } else if (banben == EnvData::BANBEN_CL1028) {
        result.push_back(std::make_pair<std::wstring, int>(L"左右互搏", 0xEB));
        result.push_back(std::make_pair<std::wstring, int>(L"食神秘籍", 0xDC));
        result.push_back(std::make_pair<std::wstring, int>(L"酒神秘籍", 0xDD));
        result.push_back(std::make_pair<std::wstring, int>(L"胡青牛医术", 0xBD));
        result.push_back(std::make_pair<std::wstring, int>(L"药王神篇", 0xC1));
    }

    bool found = false;
    for (auto& item : result) {
        if (item.second == code) {
            found = true;
            break;
        }
    }
    if (!found) {
        const auto& allWuPin = MiscData::GetAllWuPin(banben);
        const auto iter = allWuPin.find(code);
        if(iter != allWuPin.cend()) {
            result.push_back(std::make_pair<std::wstring, int>(iter->second.c_str(), std::move(code)));
        } else {
            wchar_t szBuf[32] = { 0 };
            swprintf_s(szBuf, 32, L"%04X", code);
            result.push_back(std::make_pair<std::wstring, int>(std::wstring(szBuf), std::move(code)));
        }
    }
    return result;
}

std::vector<std::pair<std::wstring, int>> MiscData::GetWuGong(int banben, int pid, int code) {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"      ", 0x0000));
    if (pid <= 0) {
        if (banben == EnvData::BANBEN_YB) {
            result.push_back(std::make_pair<std::wstring, int>(L"野球拳", 1));
            result.push_back(std::make_pair<std::wstring, int>(L"太玄神功", 23));
        } else if (banben == EnvData::BANBEN_CL) {
            result.push_back(std::make_pair<std::wstring, int>(L"野球拳", 109));
            result.push_back(std::make_pair<std::wstring, int>(L"神山剑法", 110));
            result.push_back(std::make_pair<std::wstring, int>(L"西瓜刀法", 111));
            result.push_back(std::make_pair<std::wstring, int>(L"犽月流空", 112));
        } else if (banben == EnvData::BANBEN_ZZJH) {
            result.push_back(std::make_pair<std::wstring, int>(L"六脉神剑", 61));
            result.push_back(std::make_pair<std::wstring, int>(L"独孤九剑", 33));
        } else if (banben == EnvData::BANBEN_XMB) {
            result.push_back(std::make_pair<std::wstring, int>(L"降龙十八掌", 25));
            result.push_back(std::make_pair<std::wstring, int>(L"黑级浮图", 99));
            result.push_back(std::make_pair<std::wstring, int>(L"天魔极乐", 107));
        } else if (banben == EnvData::BANBEN_TSJ) {
            result.push_back(std::make_pair<std::wstring, int>(L"雪花神剑", 397));
            result.push_back(std::make_pair<std::wstring, int>(L"降龙十八掌", 96));
        } else if (banben == EnvData::BANBEN_CL1028) {
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
        }
    }
    bool found = false;
    for (auto& item : result) {
        if (item.second == code) {
            found = true;
            break;
        }
    }
    if (!found) {
        const auto& allWuGong = MiscData::GetAllWuGong(banben);
        const auto iter = allWuGong.find(code);
        if (iter != allWuGong.cend()) {
            result.push_back(std::make_pair<std::wstring, int>(iter->second.c_str(), std::move(code)));
        } else {
            wchar_t szBuf[32] = { 0 };
            swprintf_s(szBuf, 32, L"%04X", code);
            result.push_back(std::make_pair<std::wstring, int>(std::wstring(szBuf), std::move(code)));
        }
    }
    return result;
}

const std::unordered_map<int, std::wstring>& MiscData::GetAllWuPin(int banben) {
    static std::unordered_map<int, std::wstring> s_datas;
    if (banben == EnvData::BANBEN_YB) {
        return MiscData::GetAllWuPin_YB();
    } else if (banben == EnvData::BANBEN_CL) {
        return MiscData::GetAllWuPin_CL();
    } else if (banben == EnvData::BANBEN_ZZJH) {
        return MiscData::GetAllWuPin_ZZJH();
    } else if (banben == EnvData::BANBEN_XMB) {
        return MiscData::GetAllWuPin_XMB();
    } else if (banben == EnvData::BANBEN_TSJ) {
        return MiscData::GetAllWuPin_TSJ();
    } else if (banben == EnvData::BANBEN_CL1028) {
        return MiscData::GetAllWuPin_CL1028();
    }
    return s_datas;
}

const std::unordered_map<int, std::wstring>& MiscData::GetAllWuGong(int banben) {
    static std::unordered_map<int, std::wstring> s_datas;
    if (banben == EnvData::BANBEN_YB) {
        return MiscData::GetAllWuGong_YB();
    } else if (banben == EnvData::BANBEN_CL) {
        return MiscData::GetAllWuGong_CL();
    } else if (banben == EnvData::BANBEN_ZZJH) {
        return MiscData::GetAllWuGong_ZZJH();
    } else if (banben == EnvData::BANBEN_XMB) {
        return MiscData::GetAllWuGong_XMB();
    } else if (banben == EnvData::BANBEN_TSJ) {
        return MiscData::GetAllWuGong_TSJ();
    } else if (banben == EnvData::BANBEN_CL1028) {
        return MiscData::GetAllWuGong_CL1028();
    }
    return s_datas;
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
    jyqxz_baoxi_dengji() = 0;
    jyqxz_baoxi_wugong() = 0;
    jyqxz_baoxi_maxvalue() = 0;

    jyqxz_adjust_wupin() = 0;
}