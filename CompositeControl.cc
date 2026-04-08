#include "pch.h"
#include "CompositeControl.h"
#include <commctrl.h>

// 控件ID定义
#define IDC_LABEL1     1001
#define IDC_COMBOBOX1  1002
#define IDC_LABEL2     1003
#define IDC_COMBOBOX2  1004
#define IDC_LABEL3     1005
#define IDC_COMBOBOX3  1006
#define IDC_BUTTON1    1007
#define IDC_BUTTON2    1008
#define IDC_BUTTON3    1009

CCompositeControl::CCompositeControl()
    : m_hWnd(NULL), m_hInstance(NULL), m_hParent(NULL),
    m_labelHeight(20), m_comboHeight(100), m_buttonHeight(25),
    m_verticalSpacing(10), m_horizontalSpacing(10) {
    m_WuPinAdjust = false;
    m_buttonHandlers.resize(3); // 为三个按钮预留空间
}

CCompositeControl::~CCompositeControl() {
    if (m_hWnd) {
        DestroyWindow(m_hWnd);
    }
}

BOOL CCompositeControl::Create(HWND hParent, HINSTANCE hInst, int x, int y, int width, int height) {
    m_hParent = hParent;
    m_hInstance = hInst;

    // 注册窗口类
    WNDCLASSEX wc = { 0 };
    wc.cbSize = sizeof(WNDCLASSEX);
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpfnWndProc = WindowProc;
    wc.hInstance = hInst;
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszClassName = L"CompositeControlClass";

    RegisterClassEx(&wc);

    // 创建窗口
    m_hWnd = CreateWindowEx(0, wc.lpszClassName, L"",
        WS_CHILD | WS_VISIBLE | WS_CLIPCHILDREN,
        x, y, width, height,
        hParent, NULL, hInst, this);

    return m_hWnd != NULL;
}

LRESULT CALLBACK CCompositeControl::WindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    CCompositeControl* pControl = nullptr;

    if (msg == WM_NCCREATE) {
        LPCREATESTRUCT lpcs = reinterpret_cast<LPCREATESTRUCT>(lParam);
        pControl = static_cast<CCompositeControl*>(lpcs->lpCreateParams);
        SetWindowLongPtr(hwnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(pControl));
        pControl->m_hWnd = hwnd;
    }
    else {
        pControl = reinterpret_cast<CCompositeControl*>(GetWindowLongPtr(hwnd, GWLP_USERDATA));
    }

    if (pControl) {
        return pControl->HandleMessage(msg, wParam, lParam);
    }

    return DefWindowProc(hwnd, msg, wParam, lParam);
}

LRESULT CCompositeControl::HandleMessage(UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
    case WM_CREATE:
        OnCreate();
        break;
    case WM_SIZE:
        OnSize();
        break;
    case WM_COMMAND:
        OnCommand(wParam, lParam);
        break;
    case WM_DESTROY:
        OnDestroy();
        break;
    default:
        return DefWindowProc(m_hWnd, msg, wParam, lParam);
    }
    return 0;
}

void CCompositeControl::OnCreate() {
    CreateControls();
}

void CCompositeControl::OnSize() {
    LayoutControls();
}

void CCompositeControl::OnCommand(WPARAM wParam, LPARAM lParam) {
    int id = LOWORD(wParam);
    int notificationCode = HIWORD(wParam);

    // 处理按钮点击
    if (notificationCode == BN_CLICKED) {
        m_WuPinAdjust = false;
        int buttonIndex = -1;
        if (id == IDC_BUTTON1) buttonIndex = 0;
        else if (id == IDC_BUTTON2) buttonIndex = 1;
        else if (id == IDC_BUTTON3) {
            buttonIndex = 2;
            m_WuPinAdjust = true;
        }
        if (buttonIndex >= 0 && buttonIndex < static_cast<int>(m_buttonHandlers.size()) &&
            m_buttonHandlers[buttonIndex]) {
            m_buttonHandlers[buttonIndex]();
        }
    }
}

void CCompositeControl::OnDestroy() {
    m_labelControls.clear();
    m_comboControls.clear();
    m_buttonControls.clear();
    m_hWnd = NULL;
}

void CCompositeControl::CreateControls() {
    // 创建字体
    HFONT hFont = CreateFont(18, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
        DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
        DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE, L"微软雅黑");

    // 标签文本
    std::vector<std::wstring> labels = { L"等级爆洗:", L"秘籍爆洗:", L"最值调整:" };

    // 创建三个标签和组合框
    for (int i = 0; i < 3; i++) {
        // 创建标签
        HWND hLabel = CreateWindowEx(0, L"STATIC", labels[i].c_str(),
            WS_CHILD | WS_VISIBLE | SS_RIGHT,
            0, 0, 100, m_labelHeight,
            m_hWnd, (HMENU)(INT_PTR)(IDC_LABEL1 + i * 2),
            m_hInstance, NULL);

        if (hLabel) {
            m_labelControls.push_back(hLabel);
            SendMessage(hLabel, WM_SETFONT, (WPARAM)hFont, TRUE);
        }

        // 创建组合框
        HWND hCombo = CreateWindowEx(WS_EX_CLIENTEDGE, L"COMBOBOX", L"",
            CBS_DROPDOWN | WS_CHILD | WS_VISIBLE | WS_TABSTOP | WS_VSCROLL,
            0, 0, 200, m_comboHeight,
            m_hWnd, (HMENU)(INT_PTR)(IDC_COMBOBOX1 + i * 2),
            m_hInstance, NULL);

        if (hCombo) {
            m_comboControls.push_back(hCombo);
            SendMessage(hCombo, WM_SETFONT, (WPARAM)hFont, TRUE);
        }
    }

    // 按钮文本
    std::vector<std::wstring> buttons = { L"确定", L"取消", L"应用" };

    // 创建三个按钮
    for (int i = 0; i < 3; i++) {
        DWORD dwStyle = WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON;
        if (i == 2) {
            //dwStyle |= WS_DISABLED;
        }
        HWND hButton = CreateWindowEx(0, L"BUTTON", buttons[i].c_str(),
            dwStyle,
            0, 0, 80, m_buttonHeight,
            m_hWnd, (HMENU)(INT_PTR)(IDC_BUTTON1 + i),
            m_hInstance, NULL);

        if (hButton) {
            m_buttonControls.push_back(hButton);
            SendMessage(hButton, WM_SETFONT, (WPARAM)hFont, TRUE);
        }
    }

    // 初始布局
    LayoutControls();
}

void CCompositeControl::LayoutControls() {
    RECT rcClient;
    GetClientRect(m_hWnd, &rcClient);
    int clientWidth = rcClient.right - rcClient.left;
    int clientHeight = rcClient.bottom - rcClient.top;

    // 计算控件位置
    int currentY = m_verticalSpacing;
    int labelWidth = 100;
    int comboWidth = 200;
    int buttonWidth = 80;

    // 布局标签和组合框
    for (size_t i = 0; i < m_labelControls.size() && i < m_comboControls.size(); i++) {
        // 标签位置
        MoveWindow(m_labelControls[i], m_horizontalSpacing, currentY,
            labelWidth, m_labelHeight, TRUE);

        // 组合框位置
        MoveWindow(m_comboControls[i], m_horizontalSpacing + labelWidth + 10, currentY,
            comboWidth, m_comboHeight, TRUE);

        currentY += m_labelHeight + m_verticalSpacing;
    }

    // 布局按钮
    currentY += 20; // 额外间距
    int totalButtonWidth = buttonWidth * 3 + m_horizontalSpacing * 2;
    int startX = (clientWidth - totalButtonWidth) / 2;

    for (size_t i = 0; i < m_buttonControls.size(); i++) {
        int x = startX + (buttonWidth + m_horizontalSpacing) * i;
        MoveWindow(m_buttonControls[i], x, currentY, buttonWidth, m_buttonHeight, TRUE);
    }
}

void CCompositeControl::SetComboBoxItems(int nIndex, const std::vector<std::wstring>& items) {
    if (nIndex >= 0 && nIndex < static_cast<int>(m_comboControls.size())) {
        HWND hCombo = m_comboControls[nIndex];

        // 清空现有内容
        SendMessage(hCombo, CB_RESETCONTENT, 0, 0);

        // 添加新项目
        for (const auto& item : items) {
            SendMessage(hCombo, CB_ADDSTRING, 0, (LPARAM)item.c_str());
        }

        // 设置默认选择
        if (!items.empty()) {
            SendMessage(hCombo, CB_SETCURSEL, 0, 0);
        }
    }
}

std::wstring CCompositeControl::GetComboBoxText(int nIndex) const {
    if (nIndex >= 0 && nIndex < static_cast<int>(m_comboControls.size())) {
        HWND hCombo = m_comboControls[nIndex];
        int length = SendMessage(hCombo, WM_GETTEXTLENGTH, 0, 0);
        if (length > 0) {
            std::wstring text(length + 1, L'\0');
            GetWindowText(hCombo, &text[0], length + 1);
            text.resize(length);
            return text;
        }
    }
    return L"";
}

void CCompositeControl::SetButtonClickHandler(int nIndex, std::function<void()> handler) {
    if (nIndex >= 0 && nIndex < static_cast<int>(m_buttonHandlers.size())) {
        m_buttonHandlers[nIndex] = handler;
    }
}

BOOL CCompositeControl::IsWindow() {
    if (m_hWnd == NULL) {
        return FALSE;
    }
    return ::IsWindow(m_hWnd);
}

void CCompositeControl::Destroy() {
    if (!IsWindow()) return;
    DestroyWindow(m_hWnd);
    m_hWnd = NULL;
}

void CCompositeControl::Hide() {
    if (!IsWindow()) return;
    ShowWindow(m_hWnd, SW_HIDE);
}

int CCompositeControl::GetComboBoxSelection(int nIndex) const {
    if (nIndex >= 0 && nIndex < static_cast<int>(m_comboControls.size())) {
        HWND hCombo = m_comboControls[nIndex];
        return SendMessage(hCombo, CB_GETCURSEL, 0, 0);
    }
    return -1;
}

int CCompositeControl::SetComboBoxSelection(int nIndex, int Sel) {
    if (nIndex >= 0 && nIndex < static_cast<int>(m_comboControls.size())) {
        HWND hCombo = m_comboControls[nIndex];
        return (int)::SendMessage(hCombo, CB_SETCURSEL, Sel, 0L);
    }
    return -1;
}

std::tuple<int, int, int, int> CCompositeControl::GetChoicesResult() {
    return std::make_tuple(
        std::get<0>(m_InitData),
        GetComboBoxSelection(0),
        GetComboBoxSelection(1),
        GetComboBoxSelection(2));
}

void CCompositeControl::RefreshChoices(std::tuple<int, int, int, int>&& data) {
    m_WuPinAdjust = false;
    m_InitData = data;
    if (std::get<0>(m_InitData) < 0 || std::get<0>(m_InitData) > 1) {
        std::get<0>(m_InitData) = 0;
    }
    if (std::get<1>(m_InitData) < 0 || std::get<1>(m_InitData) > 3) {
        std::get<1>(m_InitData) = 0;
    }
    if (std::get<2>(m_InitData) < 0 || std::get<2>(m_InitData) > 1) {
        std::get<2>(m_InitData) = 0;
    }
    if (std::get<3>(m_InitData) < 0 || std::get<3>(m_InitData) > 2) {
        std::get<3>(m_InitData) = 0;
    }

    SetComboBoxSelection(0, std::get<1>(m_InitData));
    SetComboBoxSelection(1, std::get<2>(m_InitData));
    SetComboBoxSelection(2, std::get<3>(m_InitData));

}