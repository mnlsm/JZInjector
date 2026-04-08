#include "pch.h"
#include "Common.h"


static LPCSTR GetExePathA() {
	static CHAR strExePath[MAX_PATH] = { 0 };
	if (!strExePath[0]) {
		::GetModuleFileNameA(NULL, strExePath, MAX_PATH);
	}
	return strExePath;
}


LPCSTR Common::GetExeFolderA() {
	static CHAR strExeFolder[MAX_PATH] = { 0 };
	if (!strExeFolder[0]) {
		memcpy(strExeFolder, GetExePathA(), MAX_PATH);
		::PathRemoveFileSpecA(strExeFolder);
	}
	return strExeFolder;
}

void Common::string_replace(std::string& str, const std::string& before,
	const std::string& after) {
	if (str.empty() || before.empty()) {
		return;
	}
	std::string::size_type pos = str.find(before, 0);
	while (pos != std::string::npos) {
		str.replace(pos, before.length(), after);
		pos += after.length();
		pos = str.find(before, pos);
	}
}


BOOL Common::CenterAndActivateChildWindow(HWND hWndChild, HWND hWndParent)
{
    // 步骤1：确保子窗口句柄有效
    if (!IsWindow(hWndChild)) {
        return FALSE;
    }

    // 如果未指定父窗口，则使用桌面窗口作为参照
    if (hWndParent == NULL) {
        hWndParent = GetDesktopWindow();
    }

    // 步骤2：恢复并显示窗口
    // 如果窗口是隐藏的，则显示它；如果是最小化的，则恢复它
    if (!IsWindowVisible(hWndChild)) {
        ShowWindow(hWndChild, SW_SHOW);
    }
    if (IsIconic(hWndChild)) { // 检查窗口是否最小化
        ShowWindow(hWndChild, SW_RESTORE);
    }

    // 步骤3：计算居中位置
    RECT rectParent, rectChild;
    GetWindowRect(hWndParent, &rectParent);
    GetWindowRect(hWndChild, &rectChild);

    int parentWidth = rectParent.right - rectParent.left;
    int parentHeight = rectParent.bottom - rectParent.top;
    int childWidth = rectChild.right - rectChild.left;
    int childHeight = rectChild.bottom - rectChild.top;

    // 计算居中坐标（相对于父窗口客户区）
    int x = rectParent.left + (parentWidth - childWidth) / 2;
    int y = rectParent.top + (parentHeight - childHeight) / 2;

    int center_x = rectParent.left + parentWidth / 2;
    int center_y = rectParent.top + parentHeight / 2;
    x = center_x - childWidth / 2;
    y = center_y - childHeight / 2;

    // 确保窗口不会完全移出屏幕可见区域
    int screenWidth = GetSystemMetrics(SM_CXSCREEN);
    int screenHeight = GetSystemMetrics(SM_CYSCREEN);
    if (x < 0) x = 0;
    if (y < 0) y = 0;
    if (x + childWidth > screenWidth) x = screenWidth - childWidth;
    if (y + childHeight > screenHeight) y = screenHeight - childHeight;

    // 步骤4：移动窗口到居中位置并置顶
    // 使用SetWindowPos，同时设置位置和Z序
    BOOL bResult = SetWindowPos(hWndChild, HWND_TOP, x, y, 0, 0,
        SWP_NOSIZE | SWP_NOACTIVATE);

    // 步骤5：激活窗口到前台
    if (bResult) {
        // 方法1: 使用SetForegroundWindow（推荐）
        bResult = SetForegroundWindow(hWndChild);

        // 方法2: 或者使用BringWindowToTop
        // bResult = BringWindowToTop(hWndChild);
    }

    return bResult;
}