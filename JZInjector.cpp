// JZInjector.cpp : 定义 DLL 的导出函数。
//

#include "pch.h"
#include "framework.h"
#include "injector_impl.h"






/*
typedef NTSTATUS(NTAPI* _NtQueryInformationProcess)(
    HANDLE           ProcessHandle,
    PROCESSINFOCLASS ProcessInformationClass,
    PVOID            ProcessInformation,
    ULONG            ProcessInformationLength,
    PULONG           ReturnLength
    );

////////////////////////////////////////////////////////////////////////////////////
//https://www.cnblogs.com/2018shawn/p/13487957.html
//detours库hook类成员函数的方法，__thiscall的hook

typedef int (__fastcall* LFN_sub_573970)(void* pthis, int dummy, const WCHAR* a2);
static LFN_sub_573970 orig_lfn_sub_573970 = nullptr;
#pragma optimize("", off)
static int __fastcall hooked_sub_573970(void* pthis, int dummy, const WCHAR* a2) {
    if (orig_lfn_sub_573970 != nullptr) {
        return orig_lfn_sub_573970(pthis, dummy, a2);
    }
    return 0;
}
#pragma optimize("", on)





///////////////////////////////////////////////////////////////////////////////////
static auto TrueAddAccessDeniedAce = AddAccessDeniedAce;
BOOL WINAPI Hooked_AddAccessDeniedAce(
    PACL  pAcl,            // 目标ACL指针 
    DWORD dwAceRevision,    // ACL版本（通常用ACL_REVISION）
    DWORD AccessMask,       // 拒绝的权限（如GENERIC_READ）
    PSID  pSid              // 要拒绝的SID（用户/组安全标识符）
) {
     return AddAccessDeniedAce(pAcl, dwAceRevision, AccessMask, pSid);
}



///////////////////////////////////////////////////////////////////////////////////////



typedef FILE* (__cdecl* TrueFopenType)(const char* filename, const char* mode);
TrueFopenType TrueFopen = fopen; // 初始指向真正的fopen

// 3. 编写自定义的Hook函数
FILE* __cdecl MyFopen(const char* filename, const char* m) {
    std::string fn = filename;
    std::string mode = m;
    FILE* result = TrueFopen(filename, m);
    // 在调用原始函数后，也可以进行操作
    if (result != NULL) {
    }
    else {
    }
    if (fn.find("jshyl_save") != std::string::npos) {
        Sleep(0);
    }

    return result;
}


//////////////////////////////////////////////////////////////////////////////////////////////
static HANDLE(WINAPI* TrueCreateFileW)(
    LPCWSTR lpFileName,
    DWORD dwDesiredAccess,
    DWORD dwShareMode,
    LPSECURITY_ATTRIBUTES lpSecurityAttributes,
    DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes,
    HANDLE hTemplateFile
    ) = CreateFileW;

HANDLE WINAPI MyCreateFileW(
    LPCWSTR lpFileName,
    DWORD dwDesiredAccess,
    DWORD dwShareMode,
    LPSECURITY_ATTRIBUTES lpSecurityAttributes,
    DWORD dwCreationDisposition,
    DWORD dwFlagsAndAttributes,
    HANDLE hTemplateFile
) {
    std::wstring fn = lpFileName;
    if (fn.find(L"jshyl_save") != std::wstring::npos) {
        Sleep(0);
    }

    return TrueCreateFileW(lpFileName, dwDesiredAccess, dwShareMode,
        lpSecurityAttributes, dwCreationDisposition,
        dwFlagsAndAttributes, hTemplateFile);
}

///////////////////////////////////////////////////////////////////////////////////////////
#pragma optimize("", off)
typedef int(__fastcall* LFN_sub_5A8700)(void* pthis, int dummy, const char** a2);
static LFN_sub_5A8700 orig_lfn_sub_5A8700 = nullptr;
static int __fastcall hooked_sub_5A8700(void* pthis, int dummy, const char** a2) {
    const char* aa = *a2;
    if (orig_lfn_sub_5A8700 != nullptr) {
        return orig_lfn_sub_5A8700(pthis, dummy, a2);
    }
    return 0;
}

typedef int(__fastcall* LFN_sub_5AD710)(void* pthis, int dummy, const char** a2, char a3, char a4);
static LFN_sub_5AD710 orig_lfn_sub_5AD710 = nullptr;
static int __fastcall hooked_sub_5AD710(void* pthis, int dummy, const char** a2, char a3, char a4) {
    const char* aa = *a2;
    char aa3 = a3;
    char aa4 = a4;
    a3 = a4 = 0x00;
    if (orig_lfn_sub_5AD710 != nullptr) {
        return orig_lfn_sub_5AD710(pthis, dummy, a2, a3, a4);
    }
    return 0;
}


typedef __int16(__cdecl* LFN_sub_54C660)(__int16* a1, unsigned int a2);
static LFN_sub_54C660 orig_lfn_sub_54C660 = nullptr;
static __int16 __cdecl hooked_sub_54C660(__int16* a1, unsigned int a2) {
    if (orig_lfn_sub_54C660 != nullptr && true) {
        return orig_lfn_sub_54C660(a1, a2);
    }
    return 0;
}

typedef __int16(__cdecl* LFN_sub_54C690)(__int16* a1, unsigned int a2);
static LFN_sub_54C690 orig_lfn_sub_54C690 = nullptr;
static __int16 __cdecl hooked_sub_54C690(__int16* a1, unsigned int a2) {
    if (orig_lfn_sub_54C690 != nullptr && true) {
        return orig_lfn_sub_54C690(a1, a2);
    }
    return 0;
}

#pragma optimize("", on)



/////////////////////////////////////////////////////////////////////////////////////////

void StartInjectors(HMODULE hModule, DWORD  ul_reason_for_call) {
    if (ul_reason_for_call != DLL_PROCESS_ATTACH) {
        return;
    }
    //DetourSetIgnoreTooSmall(TRUE);
    //DetourSetCodeModule(::GetModuleHandle(L"JZInjector.dll"), TRUE);
    HMODULE lua_module = LoadLibraryW(OLESTR("lua52.dll"));
    
    LPBYTE appBaseAddr = (LPBYTE)::GetModuleHandle(NULL);
    uint32_t codeBase = 0x400000;

    int ret = DetourTransactionBegin();
    ret = DetourUpdateThread(GetCurrentThread());

    //005A8700
    orig_lfn_sub_5A8700 = (LFN_sub_5A8700)(0x5A8700);// (appBaseAddr + 0x5A8700 - codeBase);
    DetourAttach(&(PVOID&)orig_lfn_sub_5A8700, hooked_sub_5A8700);

    //005AD710
    orig_lfn_sub_5AD710 = (LFN_sub_5AD710)(0x5AD710);// (appBaseAddr + 0x5AD710 - codeBase);
    DetourAttach(&(PVOID&)orig_lfn_sub_5AD710, hooked_sub_5AD710);


    //0054C660
    orig_lfn_sub_54C660 = (LFN_sub_54C660)(0x54C660);// (appBaseAddr + 0x54C660 - codeBase);
    DetourAttach(&(PVOID&)orig_lfn_sub_54C660, hooked_sub_54C660);

    //0054C690
    orig_lfn_sub_54C690 = (LFN_sub_54C660)(0x54C690);// (appBaseAddr + 0x54C690 - codeBase);
    DetourAttach(&(PVOID&)orig_lfn_sub_54C690, hooked_sub_54C690);


    //orig_lfn_sub_573970 = (LFN_sub_573970)(appBaseAddr + 0x573970 - codeBase);
    //DetourAttach(&(PVOID&)orig_lfn_sub_573970, hooked_sub_573970);
    
   // DetourDetach(&(PVOID&)TrueAddAccessDeniedAce, Hooked_AddAccessDeniedAce);
    
    LONG error = DetourAttach(&(PVOID&)TrueFopen, MyFopen);
    if (error != NO_ERROR) {
        DetourTransactionAbort();
        return ;
    }

    if (DetourAttach(&(PVOID&)TrueCreateFileW, MyCreateFileW) != NO_ERROR) {
        DetourTransactionAbort();
        return;
    }



    ret = DetourTransactionCommit();

    return;
}
*/

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


lua_State* g_lua_state = nullptr;


typedef lua_State*(__cdecl* LFN_luaL_newstate)();
static LFN_luaL_newstate orig_luaL_newstate = nullptr;
static lua_State* __cdecl hooked_luaL_newstat() {
    if (orig_luaL_newstate != nullptr) {
        g_lua_state = orig_luaL_newstate();
    }
    InjectorImpl::Get()->Start(g_lua_state);
    return g_lua_state;
}


void __cdecl hooked_lua_getglobal(lua_State* L, const char* var) {
    if (orig_lua_getglobal != nullptr) {
        orig_lua_getglobal(L, var);
        if (var != nullptr && _stricmp(var, "JY_Main") == 0) {
            InjectorImpl::Get()->OnLuaMainRun();
        }
    }
}





//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
typedef LRESULT (WINAPI* LFN_DispatchMessageW)(const MSG* lpmsg);
static LFN_DispatchMessageW orig_DispatchMessageW = nullptr;
static LRESULT WINAPI Hooked_DispatchMessageW(const MSG* lpmsg) {
    LRESULT lRet = 1L;
    InjectorImpl::Get()->PeekDispatchMessage(lpmsg, true);
    if (orig_DispatchMessageW != nullptr) {
        lRet = orig_DispatchMessageW(lpmsg);
    }
    InjectorImpl::Get()->PeekDispatchMessage(lpmsg, false);
    return lRet;
}

typedef LRESULT(WINAPI* LFN_DispatchMessageA)(const MSG* lpmsg);
static LFN_DispatchMessageA orig_DispatchMessageA = nullptr;
static LRESULT WINAPI Hooked_DispatchMessageA(const MSG* lpmsg) {
    LRESULT lRet = 1L;
    InjectorImpl::Get()->PeekDispatchMessage(lpmsg, true);
    if (orig_DispatchMessageA != nullptr) {
        lRet = orig_DispatchMessageA(lpmsg);
    }
    InjectorImpl::Get()->PeekDispatchMessage(lpmsg, false);
    return lRet;
}




typedef LRESULT(WINAPI* LFN_TranslateMessageW)(const MSG* lpmsg);
static LFN_TranslateMessageW orig_TranslateMessageW = nullptr;
static LRESULT WINAPI Hooked_TranslateMessageW(const MSG* lpmsg) {
    LRESULT lRet = 1L;
    InjectorImpl::Get()->PeekTranslateMessageMessage(lpmsg, true);
    if (orig_DispatchMessageW != nullptr) {
        lRet = orig_TranslateMessageW(lpmsg);
    }
    InjectorImpl::Get()->PeekTranslateMessageMessage(lpmsg, false);
    return lRet;
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



LRESULT CHookMgrImpl::OnCallWndRetProc_i(int nCode, WPARAM wParam, LPARAM lParam) {
    return CallNextHookEx(m_hCallWndRetHook, nCode, wParam, lParam);
}

//----------------------------------------------------------------------------------------------------------------------------------------------------

void StartInjectors(HMODULE hModule, DWORD  ul_reason_for_call) {
    if (ul_reason_for_call != DLL_PROCESS_ATTACH) {
        return;
    }
    InjectorImpl::Get()->Init(GetModuleHandle(NULL));
    LPBYTE appBaseAddr = (LPBYTE)::GetModuleHandle(NULL);
    uint32_t codeBase = 0x400000;
    HMODULE lua_module = LoadLibraryW(OLESTR("lua52.dll"));
    HMODULE user32_module = LoadLibraryW(OLESTR("user32.dll"));


    int ret = DetourTransactionBegin();
    ret = DetourUpdateThread(GetCurrentThread());
    orig_luaL_newstate = (LFN_luaL_newstate)GetProcAddress(lua_module, "luaL_newstate");
    if (orig_luaL_newstate != NULL) {
        DetourAttach(&(PVOID&)orig_luaL_newstate, hooked_luaL_newstat); 
    }

    orig_lua_getglobal = (LFN_lua_getglobal)GetProcAddress(lua_module, "lua_getglobal");
    if (orig_lua_getglobal != NULL) {
        DetourAttach(&(PVOID&)orig_lua_getglobal, hooked_lua_getglobal);
    }


    orig_luaL_loadstring = (LFN_luaL_loadstring)GetProcAddress(lua_module, "luaL_loadstring");
    orig_lua_pcallk = (LFN_lua_pcallk)GetProcAddress(lua_module, "lua_pcallk");
    orig_lua_settop = (LFN_lua_settop)GetProcAddress(lua_module, "lua_settop");
    orig_lua_tolstring = (LFN_lua_tolstring)GetProcAddress(lua_module, "lua_tolstring");
    orig_lua_rawgeti = (LFN_lua_rawgeti)GetProcAddress(lua_module, "lua_rawgeti");
    orig_lua_setupvalue = (LFN_lua_setupvalue)GetProcAddress(lua_module, "lua_setupvalue");
    orig_lua_createtable = (LFN_lua_createtable)GetProcAddress(lua_module, "lua_createtable");
    orig_lua_setmetatable = (LFN_lua_setmetatable)GetProcAddress(lua_module, "lua_setmetatable");
    orig_lua_getfield = (LFN_lua_getfield)GetProcAddress(lua_module, "lua_getfield");
    orig_lua_type = (LFN_lua_type)GetProcAddress(lua_module, "lua_type");
    orig_lua_tonumberx = (LFN_lua_tonumberx)GetProcAddress(lua_module, "lua_tonumberx");
    orig_lua_pushinteger = (LFN_lua_pushinteger)GetProcAddress(lua_module, "lua_pushinteger");

    orig_DispatchMessageW = (LFN_DispatchMessageW)GetProcAddress(user32_module, "DispatchMessageW");
    if (orig_DispatchMessageW != NULL) {
        DetourAttach(&(PVOID&)orig_DispatchMessageW, Hooked_DispatchMessageW);
    }
    orig_DispatchMessageA = (LFN_DispatchMessageA)GetProcAddress(user32_module, "DispatchMessageA");
    if (orig_DispatchMessageA != NULL) {
        DetourAttach(&(PVOID&)orig_DispatchMessageA, Hooked_DispatchMessageA);
    }

    orig_TranslateMessageW = (LFN_TranslateMessageW)GetProcAddress(user32_module, "TranslateMessageW");
    if (orig_TranslateMessageW != NULL) {
        DetourAttach(&(PVOID&)orig_TranslateMessageW, Hooked_TranslateMessageW);
    }

    ret = DetourTransactionCommit();

}


extern "C" JZINJECTOR_API int fnJZInjector(void)
{
    return 0;
}













/*
bool callLuaFunction(lua_State* L, const char* funcName) {
    lua_getglobal(L, funcName);
    if (!lua_isfunction(L, -1)) {
        std::cerr << funcName << " is not a function" << std::endl;
        lua_pop(L, 1);
        return false;
    }
    return true;
}

    // 示例 4：调用返回表的函数
    if (callLuaFunction(L, "getConfig")) {
        if (lua_pcall(L, 0, 1, 0) == LUA_OK) {
            if (lua_istable(L, -1)) {
                lua_getfield(L, -1, "width");
                lua_getfield(L, -1, "height");
                lua_getfield(L, -1, "title");

                int width = (int)lua_tonumber(L, -3);
                int height = (int)lua_tonumber(L, -2);
                const char* title = lua_tostring(L, -1);

                std::cout << "Config: " << title
                          << " (" << width << "x" << height << ")" << std::endl;

                lua_pop(L, 4);  // 弹出三个字段值 + 表
            } else {
                lua_pop(L, 1);
            }
        }
    }



 ---------------------------------------------------------------------------------------------------

 -- 创建字典
local dict = {
    name = "Alice",
    age = 25,
    city = "New York",
    ["email"] = "alice@example.com",  -- 键包含特殊字符时用方括号
    [123] = "number key"  -- 数字作为键
}

-- 访问元素
print(dict.name)        --> Alice
print(dict["age"])      --> 25
print(dict[123])        --> number key

-- 修改/添加元素
dict.age = 26
dict.job = "Engineer"
dict["phone"] = "123-456-7890"

-- 删除元素
dict.city = nil

-- 遍历字典
for key, value in pairs(dict) do
    print(key, "=", value)
end





*/




