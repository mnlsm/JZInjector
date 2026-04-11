#include "pch.h"
#include "CompositeDialog.h"
#include "Common.h"



LRESULT CompositeDialog::OnInitDialog(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/)
{
    // center the dialog on the screen
    //CenterWindow();

    // set icons
    HICON hIcon = (HICON)::LoadImage(_Module.GetResourceInstance(), MAKEINTRESOURCE(IDR_MAINFRAME),
        IMAGE_ICON, ::GetSystemMetrics(SM_CXICON), ::GetSystemMetrics(SM_CYICON), LR_DEFAULTCOLOR);
    SetIcon(hIcon, TRUE);
    HICON hIconSmall = (HICON)::LoadImage(_Module.GetResourceInstance(), MAKEINTRESOURCE(IDR_MAINFRAME),
        IMAGE_ICON, ::GetSystemMetrics(SM_CXSMICON), ::GetSystemMetrics(SM_CYSMICON), LR_DEFAULTCOLOR);
    SetIcon(hIconSmall, FALSE);

    InitUi();

    CenterWindow();

    //m_treePropertys.EnableItem(hName, FALSE);
    //m_treePropertys.EnableItem(hOpt, FALSE);

    return TRUE;
}

LRESULT CompositeDialog::OnClose(UINT /*uMsg*/, WPARAM /*wParam*/, LPARAM /*lParam*/, BOOL& /*bHandled*/) {
    if (IsWindowVisible()) {
        ShowWindow(SW_HIDE);
        m_delegate->OnUiHide(this);
    }
    return TRUE;
}

LRESULT CompositeDialog::OnPersonSelChange(WORD /*wNotifyCode*/, WORD /*wID*/, HWND /*hWndCtl*/, BOOL& /*bHandled*/) {
    if (!m_updatingUi) {
        UpdateUi(false);
    }
    return 1L;
}


LRESULT CompositeDialog::OnApply(WORD /*wNotifyCode*/, WORD /*wID*/, HWND /*hWndCtl*/, BOOL& /*bHandled*/) {
    UpdateDelegateCheatData();
    return 0;
}

LRESULT CompositeDialog::OnOK(WORD /*wNotifyCode*/, WORD wID, HWND /*hWndCtl*/, BOOL& /*bHandled*/) {
    UpdateDelegateCheatData();
    ShowWindow(SW_HIDE);
    m_delegate->OnUiHide(this);
    return 0;
}

LRESULT CompositeDialog::OnCancel(WORD /*wNotifyCode*/, WORD wID, HWND /*hWndCtl*/, BOOL& /*bHandled*/) {
    ShowWindow(SW_HIDE);
    m_delegate->OnUiHide(this);
    return 0;
}

void CompositeDialog::InitUi() {
    m_comboPersons.Attach(GetDlgItem(IDC_COMBO1));
    /*
    auto personData = PersonData::GetPersons(false);
    for (auto& person : personData) {
        int index = m_comboPersons.AddString(person.first.c_str());
        m_comboPersons.SetItemData(index, person.second);
    }
    m_comboPersons.SetCurSel(0);
    */

    m_images.Create(IDB_PROPERTYTREE, 16, 1, RGB(255, 0, 255));
    m_treePropertys.SubclassWindow(GetDlgItem(IDC_TREE1));
    m_treePropertys.SetImageList(m_images, TVSIL_NORMAL);


    HTREEITEM hItem = m_treePropertys.InsertItem(PropCreateReadOnlyItem(_T("提速、最值、物品")), 13, 13, TVI_ROOT);
    if (true) {
        LPCTSTR pList[] = { L"默认", L"普通", L"快速", L"全能" , NULL };
        m_hItemDengJi = m_treePropertys.InsertItem(PropCreateList(_T("升级提速"), pList), 12, 12, hItem);
    }
    if (true) {
        LPCTSTR pList[] = { L"默认", L"快速" , L"极速" ,NULL };
        m_hItemMiJi = m_treePropertys.InsertItem(PropCreateList(_T("修炼提速"), pList), 12, 12, hItem);
    }
    if (true) {
        LPCTSTR pList[] = { L"默认", L"上调25%", L"上调50%" , NULL };
        m_hItemZuiZhi = m_treePropertys.InsertItem(PropCreateList(_T("最值设定"), pList), 12, 12, hItem);
    }

    if (true) {
        LPCTSTR pList[] = { L"关闭", L"开启", NULL };
        m_hItemWuPin = m_treePropertys.InsertItem(PropCreateList(_T("物品调整"), pList), 12, 12, hItem);
    }

    hItem = m_treePropertys.InsertItem(PropCreateReadOnlyItem(_T("人物属性")), 13, 13, TVI_ROOT);
    m_hItemPerson = hItem;
    /*
    if (true) {
        LPCTSTR pList[] = { L"低资质", L"高资质" , NULL };
        m_hItemPersonZiZhi = m_treePropertys.InsertItem(PropCreateList(_T("武功资质"), pList), 12, 12, hItem);
    }
    if (true) {
        LPCTSTR pList[] = { L"低级", L"中级" , L"高级" , NULL };
        m_hItemPersonWuChang = m_treePropertys.InsertItem(PropCreateList(_T("武功常识"), pList), 12, 12, hItem);
    }
    */
    if (true) {
        m_hItemPersonXiuLian = m_treePropertys.InsertItem(PropCreateList(_T("修炼秘籍")), 12, 12, hItem);
    }
    if (true) {
        m_hItemPersonWuChang = m_treePropertys.InsertItem(PropCreateList(_T("武学常识")), 12, 12, hItem);
        CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonWuChang);
        for (size_t i = 0; i <= 100; i++) {
            list->AddListItem(std::to_wstring(i).c_str(), i);
        }
        CComVariant v(0, VT_I4);
        m_treePropertys.SetItemValue(m_hItemPersonWuChang, &v);
    }
    if (true) {
        for (int i = 0; i < m_hItemPersonWuGongs.size(); i++) {
            std::wstring title = L"武功" + std::to_wstring(i + 1);
            m_hItemPersonWuGongs[i] = m_treePropertys.InsertItem(PropCreateList(title.c_str()), 12, 12, hItem);
        }
    }
}


void CompositeDialog::UpdateUi(bool reset) {
    m_updatingUi = true;
    int person_id = 0;
    if (m_comboPersons.GetCount() <= 0 || reset) {
        person_id = 0;
    } else {
        int index = m_comboPersons.GetCurSel();
        person_id = m_comboPersons.GetItemData(index);
    }
    CheatData data;
    data.person().jyqxz_person_id() = person_id;
    m_delegate->GetCheatData(this, data);
    UpdateUiFromCheatData(reset, data);
    m_updatingUi = false;

    m_treePropertys.SetFocus();
    m_treePropertys.SelectItem(m_hItemPerson);
}


void CompositeDialog::UpdateUiFromCheatData(bool reset, CheatData& cheatData) {
    if (reset || m_comboPersons.GetCount() <= 0) {
        m_comboPersons.ResetContent();
        auto personData = PersonData::GetPersons(cheatData.env().BanBen, true);
        for (auto& person : personData) {
            int index = m_comboPersons.AddString(person.first.c_str());
            m_comboPersons.SetItemData(index, person.second);
        }
        m_comboPersons.SetCurSel(0);
    }
    CComVariant v(cheatData.misc().jyqxz_baoxi_dengji(), VT_I4);
    m_treePropertys.SetItemValue(m_hItemDengJi, &v);
    v = CComVariant(cheatData.misc().jyqxz_baoxi_wugong(), VT_I4);
    m_treePropertys.SetItemValue(m_hItemMiJi, &v);
    v = CComVariant(cheatData.misc().jyqxz_baoxi_maxvalue(), VT_I4);
    m_treePropertys.SetItemValue(m_hItemZuiZhi, &v);
    v = CComVariant(cheatData.misc().jyqxz_adjust_wupin(), VT_I4);
    m_treePropertys.SetItemValue(m_hItemWuPin, &v);
    /*
    if (true) {
        int zizhi = cheatData.person().jyqxz_person_zizhi();
        int val = (zizhi > 45) ? 1 : 0;
        v = CComVariant(val, VT_I4);
        m_treePropertys.SetItemValue(m_hItemPersonZiZhi, &v);
    }
    if (true) {
        int wuchang = cheatData.person().jyqxz_person_wuchang();
        int val = (wuchang > 0) ? 1 : 0;
        val = (wuchang > 80) ? 2 : val;
        v = CComVariant(val, VT_I4);
        m_treePropertys.SetItemValue(m_hItemPersonWuChang, &v);
    }
    */
    if (true) {
        size_t val = cheatData.person().jyqxz_person_wuchang();
        if (val > 100) val = 0;
        v = CComVariant(val, VT_UI4);
        m_treePropertys.SetItemValue(m_hItemPersonWuChang, &v);
        //m_treePropertys.EnableItem(m_hItemPersonWuChang, (cheatData.person().jyqxz_person_id() == 0));
    }
    if (true) {
        int val = -1, index = 0;
        auto xiuLianData = MiscData::GetXiuLian(cheatData.env().BanBen, 
                cheatData.person().jyqxz_person_xiulian());
        CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonXiuLian);
        list->RemoveAll();
        for (auto& d : xiuLianData) {
            list->AddListItem(d.first.c_str(), d.second);
            if (d.second == cheatData.person().jyqxz_person_xiulian()) {
                val = index;
            }
            ++index;
        }
        v = CComVariant(val, VT_I4);
        m_treePropertys.SetItemValue(m_hItemPersonXiuLian, &v);
    }

    if (true) {
        auto wugongs = cheatData.person().jyqxz_person_wugongs();
        for (int i = 0; i < m_hItemPersonWuGongs.size(); i++) {
            int val = -1, index = 0;
            auto wugongData = MiscData::GetWuGong(cheatData.env().BanBen, 
                cheatData.person().jyqxz_person_id(), wugongs[i]);
            CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonWuGongs[i]);
            list->RemoveAll();
            for (auto& d : wugongData) {
                list->AddListItem(d.first.c_str(), d.second);
                if (d.second == wugongs[i]) {
                    val = index;
                }
                ++index;
            }
            v = CComVariant(val, VT_I4);
            m_treePropertys.SetItemValue(m_hItemPersonWuGongs[i], &v);
        }
    }
}

void CompositeDialog::UpdateDelegateCheatData() {
    int index = m_comboPersons.GetCurSel();
    if (index < 0) return;
    GetDlgItem(ID_APP_ABOUT).EnableWindow(FALSE);

    CheatData cheatData;
    CComVariant v;
    m_treePropertys.GetItemValue(m_hItemDengJi, &v);
    cheatData.misc().jyqxz_baoxi_dengji() = v.lVal;
    v.Clear();
    m_treePropertys.GetItemValue(m_hItemMiJi, &v);
    cheatData.misc().jyqxz_baoxi_wugong() = v.lVal;
    v.Clear();
    m_treePropertys.GetItemValue(m_hItemZuiZhi, &v);
    cheatData.misc().jyqxz_baoxi_maxvalue() = v.lVal;
    v.Clear();
    m_treePropertys.GetItemValue(m_hItemWuPin, &v);
    cheatData.misc().jyqxz_adjust_wupin() = v.lVal;
    v.Clear();
    
    
    cheatData.person().jyqxz_person_id() = m_comboPersons.GetItemData(index);
    CComBSTR bstr;
    m_comboPersons.GetLBTextBSTR(index, bstr.m_str);
    cheatData.person().jyqxz_person_name() = CT2A(bstr).m_psz;
    /*
    if (true) {
        m_treePropertys.GetItemValue(m_hItemPersonZiZhi, &v);
        cheatData.person().jyqxz_person_zizhi() = (v.lVal == 0) ? 45 : 90;
    }
    v.Clear();
    if (true) {
        m_treePropertys.GetItemValue(m_hItemPersonWuChang, &v);
        cheatData.person().jyqxz_person_wuchang() = (v.lVal > 0) ? 40 : 0;
        cheatData.person().jyqxz_person_wuchang() = (v.lVal > 1) ? 80 : 40;
    }
    v.Clear();
    */
    if (true) {
        CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonWuChang);
        cheatData.person().jyqxz_person_wuchang() = list->GetListItemData();
    }
    v.Clear();
    if (true) {
        CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonXiuLian);
        cheatData.person().jyqxz_person_xiulian() = list->GetListItemData();
    }
    v.Clear();
    if (true) {
        auto& wugongs = cheatData.person().jyqxz_person_wugongs();
        for (int i = 0; i < m_hItemPersonWuGongs.size(); i++) {
            CPropertyListItem* list = (CPropertyListItem*)m_treePropertys.GetItemProperty(m_hItemPersonWuGongs[i]);
            wugongs[i] = list->GetListItemData();
            v.Clear();
        }
    }
    m_delegate->UpdateCheatData(this, cheatData);
    GetDlgItem(ID_APP_ABOUT).EnableWindow(TRUE);
}
