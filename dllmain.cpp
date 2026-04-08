// dllmain.cpp : 定义 DLL 应用程序的入口点。
#include "pch.h"
#include "JZInjector.h"

CAppModule _Module;

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{   
    StartInjectors(hModule, ul_reason_for_call);
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        INITCOMMONCONTROLSEX iccx;
        iccx.dwSize = sizeof(iccx);
        iccx.dwICC = ICC_COOL_CLASSES | ICC_BAR_CLASSES;
        ::InitCommonControlsEx(&iccx);
        _Module.Init(NULL, hModule);
        break;
    case DLL_PROCESS_DETACH:
        _Module.Term();
        break;
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
        break;
    }
    return TRUE;
}

