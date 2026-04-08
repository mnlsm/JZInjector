#pragma once

#define WINVER		0x0600
#define _WIN32_IE	0x0600
#define _RICHEDIT_VER	0x0300

#include <array>
#include <vector>
#include <string>
#include <functional>
#include <memory>
#include <map>
#include <unordered_map>
#include <tuple>



#define WIN32_LEAN_AND_MEAN             // 从 Windows 头文件中排除极少使用的内容
// Windows 头文件
#include <windows.h>
#include <psapi.h>
#include <tlhelp32.h>
#include <winternl.h>
#include <aclapi.h>    // 主头文件（包含ACL相关API）
#include <sddl.h>      // 可选（用于SID字符串转换）
#include <shlwapi.h>

#include <atlbase.h>
#include <atlapp.h>
#include <atlwin.h>

#include <atlframe.h>
#include <atlctrls.h>
#include <atldlgs.h>
#include <atlctrlw.h>

extern CAppModule _Module;

#pragma comment(lib, "psapi.lib")
#pragma comment(lib, "kernel32.lib")
#pragma comment(lib, "Advapi32.lib")
#pragma comment(lib, "detours.lib")
#pragma comment(lib, "shlwapi.lib")


//#ifdef DEBUG || NDEBUG
#define DEBUGLOG 
//#endif
