#pragma once

#include "resource.h"
#include "PropertyTree.h"
#include "CheatData.h"


class CompositeDialog : public CDialogImpl<CompositeDialog>
{
public:
    class Delegate {
        public: 
            virtual ~Delegate() = default;
        public:
            virtual void OnUiHide(CompositeDialog* caller) = 0;
            virtual void GetCheatData(CompositeDialog* caller, CheatData& cheatData) = 0;
            virtual void UpdateCheatData(CompositeDialog* caller, CheatData& cheatData) = 0;
    };
public:
    inline void SetDelegate(Delegate* delegatee) { m_delegate = delegatee; }
    inline void UpdateUi(bool reset);

public:
    enum { IDD = IDD_MAINDLG };
    BEGIN_MSG_MAP(CompositeDialog)
        MESSAGE_HANDLER(WM_INITDIALOG, OnInitDialog)
        MESSAGE_HANDLER(WM_CLOSE, OnClose)
        COMMAND_ID_HANDLER(ID_APP_ABOUT, OnApply)
        COMMAND_ID_HANDLER(IDOK, OnOK)
        COMMAND_ID_HANDLER(IDCANCEL, OnCancel)
        COMMAND_HANDLER(IDC_COMBO1, CBN_SELCHANGE, OnPersonSelChange)
        
        REFLECT_NOTIFICATIONS()
    END_MSG_MAP()

    LRESULT OnInitDialog(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
    LRESULT OnClose(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/);
    LRESULT OnPersonSelChange(WORD /*wNotifyCode*/, WORD /*wID*/, HWND /*hWndCtl*/, BOOL& /*bHandled*/);

    LRESULT OnApply(WORD /*wNotifyCode*/, WORD /*wID*/, HWND /*hWndCtl*/, BOOL& /*bHandled*/);
    LRESULT OnOK(WORD /*wNotifyCode*/, WORD wID, HWND /*hWndCtl*/, BOOL& /*bHandled*/);
    LRESULT OnCancel(WORD /*wNotifyCode*/, WORD wID, HWND /*hWndCtl*/, BOOL& /*bHandled*/);

private:
    void InitUi();
    void UpdateUiFromCheatData(CheatData& cheatData);
    void UpdateDelegateCheatData();

private:
    CImageList m_images;
    CPropertyTreeCtrl m_treePropertys;
    CComboBox m_comboPersons;

    HTREEITEM m_hItemDengJi, m_hItemMiJi, m_hItemZuiZhi, m_hItemWuPin;

    //HTREEITEM m_hItemPersonZiZhi, m_hItemPersonWuChang;
    HTREEITEM m_hItemPerson;
    HTREEITEM m_hItemPersonXiuLian;
    std::array<HTREEITEM, PersonData::WUGONG_COUNT> m_hItemPersonWuGongs;


private:
    Delegate* m_delegate;
    bool m_updatingUi = false;


};
