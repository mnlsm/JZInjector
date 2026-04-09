// JZInjector.cpp : 定义 DLL 的导出函数。
//

#include "pch.h"
#include "framework.h"
#include "injector_impl.h"

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


