#ifndef _COMPOSITE_CONTROL_H_
#define _COMPOSITE_CONTROL_H_

#include <windows.h>
#include <vector>
#include <string>
#include <functional>

class CCompositeControl {
public:
    CCompositeControl();
    virtual ~CCompositeControl();

    // 创建控件窗口
    BOOL Create(HWND hParent, HINSTANCE hInst, int x, int y, int width, int height);
    HWND GetHwnd() const { return m_hWnd; }
    BOOL IsWindow();
    void Destroy();
    void Hide();

    // 组合框操作
    void SetComboBoxItems(int nIndex, const std::vector<std::wstring>& items);
    int GetComboBoxSelection(int nIndex) const;
    std::wstring GetComboBoxText(int nIndex) const;

    // 按钮点击事件回调
    void SetButtonClickHandler(int nIndex, std::function<void()> handler);

public:
    std::tuple<int, int, int, int> GetChoicesResult();
    void RefreshChoices(std::tuple<int, int, int, int>&& data);
    inline bool IsWuPinAdjust() { return m_WuPinAdjust; }

protected:
    static LRESULT CALLBACK WindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
    LRESULT HandleMessage(UINT msg, WPARAM wParam, LPARAM lParam);

    void OnCreate();
    void OnSize();
    void OnCommand(WPARAM wParam, LPARAM lParam);
    void OnDestroy();

    int SetComboBoxSelection(int nIndex, int Sel);

private:
    void CreateControls();
    void LayoutControls();

    HWND m_hWnd;
    HINSTANCE m_hInstance;
    HWND m_hParent;

    // 控件句柄数组
    std::vector<HWND> m_labelControls;    // 标签
    std::vector<HWND> m_comboControls;    // 组合框
    std::vector<HWND> m_buttonControls;    // 按钮

    // 按钮事件处理器
    std::vector<std::function<void()>> m_buttonHandlers;

    // 控件尺寸和间距
    int m_labelHeight;
    int m_comboHeight;
    int m_buttonHeight;
    int m_verticalSpacing;
    int m_horizontalSpacing;

    std::tuple<int, int, int, int> m_InitData;
    bool m_WuPinAdjust;
};

#endif // _COMPOSITE_CONTROL_H_