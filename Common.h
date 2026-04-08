#pragma once
#include "framework.h"
#include <cstdint>
#include <string>
#include <vector>
#include <tuple>

class Common {

private:
	Common() = delete;
	~Common() = delete;

public:
	static LPCSTR GetExeFolderA();

	static void string_replace(std::string& str, const std::string& before,
		const std::string& after);

	static BOOL CenterAndActivateChildWindow(HWND hWndChild, HWND hWndParent);
};