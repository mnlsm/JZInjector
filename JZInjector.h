// 下列 ifdef 块是创建使从 DLL 导出更简单的
// 宏的标准方法。此 DLL 中的所有文件都是用命令行上定义的 JZINJECTOR_EXPORTS
// 符号编译的。在使用此 DLL 的
// 任何项目上不应定义此符号。这样，源文件中包含此文件的任何其他项目都会将
// JZINJECTOR_API 函数视为是从 DLL 导入的，而此 DLL 则将用此宏定义的
// 符号视为是被导出的。
#pragma once


#include <cstdint>
#include <string>
#include <vector>
#include <tuple>

#include <lauxlib.h>
#include <detours.h>
#include "HookMgr.h"




#ifdef JZINJECTOR_EXPORTS
#define JZINJECTOR_API __declspec(dllexport)
#else
#define JZINJECTOR_API __declspec(dllimport)
#endif

extern "C" JZINJECTOR_API int fnJZInjector(void);

void StartInjectors(HMODULE hModule, DWORD  ul_reason_for_call);

class CHookMgrImpl
	: public CHookMgr<CHookMgrImpl> {
private:
	CHookMgrImpl() = default;
public:
	~CHookMgrImpl() = default;

public:
	static CHookMgrImpl* GetInstance();
	LRESULT OnCallWndRetProc_i(int nCode, WPARAM wParam, LPARAM lParam) override;


};

