#include "pch.h"
#include "CheatData.h"

std::vector<std::pair<std::wstring, int>> PersonData::GetPersons_CL() {
    std::vector<std::pair<std::wstring, int>> result;
    result.push_back(std::make_pair<std::wstring, int>(L"主角", 0x00));

    return result;
}

const std::unordered_map<int, std::wstring>& MiscData::GetAllWuPin_CL() {
    static std::unordered_map<int, std::wstring> s_datas;
    //s_datas[0] = L"小还丹";
    return s_datas;
}

const std::unordered_map<int, std::wstring>& MiscData::GetAllWuGong_CL() {
    static std::unordered_map<int, std::wstring> s_datas;
    //s_datas[0] = L"普通攻击";

    return s_datas;
}
