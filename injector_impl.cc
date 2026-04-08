#include "pch.h"
#include "injector_impl.h"
#include "Common.h"
#include "FileLogger.h"

#define LUA_INIT_FAILED (-14524)
#define WM_DELAYLUAMAIN WM_APP + 1
#define WM_DELAYSHOWDLG WM_APP + 2


LFN_luaL_loadstring orig_luaL_loadstring = nullptr;
LFN_lua_pcallk orig_lua_pcallk = nullptr;
LFN_lua_settop orig_lua_settop = nullptr;
LFN_lua_tolstring orig_lua_tolstring = nullptr;
LFN_lua_rawgeti orig_lua_rawgeti = nullptr;
LFN_lua_setupvalue orig_lua_setupvalue = nullptr;
LFN_lua_createtable orig_lua_createtable = nullptr;
LFN_lua_setmetatable orig_lua_setmetatable = nullptr;
LFN_lua_getglobal orig_lua_getglobal = nullptr;
LFN_lua_getfield orig_lua_getfield = nullptr;
LFN_lua_type orig_lua_type = nullptr;
LFN_lua_tonumberx orig_lua_tonumberx = nullptr;
LFN_lua_pushinteger orig_lua_pushinteger = nullptr;

static bool has_lua_hook_sucessed() {
    if (orig_luaL_loadstring == nullptr) {
        return false;
    }
    if (orig_lua_pcallk == nullptr) {
        return false;
    }
    if (orig_lua_settop == nullptr) {
        return false;
    }
    if (orig_lua_tolstring == nullptr) {
        return false;
    }
    if (orig_lua_rawgeti == nullptr) {
        return false;
    }
    if (orig_lua_setupvalue == nullptr) {
        return false;
    }
    if (orig_lua_createtable == nullptr) {
        return false;
    }
    if (orig_lua_setmetatable == nullptr) {
        return false;
    }
    if (orig_lua_getfield == nullptr) {
        return false;
    }
    if (orig_lua_type == nullptr) {
        return false;
    }
    if (orig_lua_tonumberx == nullptr) {
        return false;
    }
    if (orig_lua_pushinteger == nullptr) {
        return false;
    }
    return true;
}

static std::tuple<int,std::string> lua_dostring_ex(lua_State* l, const char* code) {
    if (l == nullptr || !has_lua_hook_sucessed()) {
        return std::make_tuple(LUA_INIT_FAILED, "lua hook error!!!");
    }
    int lua_ret = orig_luaL_loadstring(l, code);
    if (lua_ret != LUA_OK) {
       auto ret = std::make_tuple(lua_ret, lua_tostring_ex(l, -1));
       lua_pop_ex(l, 1);
       return ret;
    }
    lua_pushglobaltable_ex(l);               
    const char* eee = orig_lua_setupvalue(l, -2, 1);             
    lua_ret = orig_lua_pcallk(l, 0, LUA_MULTRET, 0, 0, NULL);
    if (lua_ret != LUA_OK) {
        auto ret = std::make_tuple(lua_ret, lua_tostring_ex(l, -1));
        lua_pop_ex(l, 1);
        return ret;
    }
    return std::make_tuple(0, "");
}


void DisableStrictMode(lua_State* L) {
    // 获取 _G
    lua_pushglobaltable_ex(L);

    // 创建新元表
    lua_newtable_ex(L);

    // 设置元表
    int lua_ret = orig_lua_setmetatable(L, -2);
    if (lua_ret != 1) {
        //printf("Failed to set metatable.\n");
    }
    lua_pop_ex(L, 1);  // 弹出 _G
}

bool CallLuaFunction(lua_State* L, const char* funcName) {
    orig_lua_getglobal(L, funcName);
    if (!lua_isfunction_ex(L, -1)) {
        lua_pop_ex(L, 1);
        return false;
    }
    return true;
}

//------------------------------------------------------------------------------------------------------

InjectorImpl* InjectorImpl::Get() {
    static InjectorImpl* sInst = nullptr;
    if (sInst == nullptr) {
        sInst = new InjectorImpl();
    }
    return sInst;
}

void InjectorImpl::Init(HINSTANCE hInst) {
    hInst_ = hInst;
    mDialogEx.SetDelegate(this);
}

bool InjectorImpl::Start(lua_State* l) {
    if (lua_state_ != nullptr) {
        return true;
    }
    exe_path_ = Common::GetExeFolderA();
    config_filepath_ = exe_path_ + "\\JZInjector.ini";
    log_filepath_ = exe_path_ + "\\JZInjector.log";
    ::DeleteFileA(log_filepath_.c_str());
#ifdef DEBUGLOG
    FileLogger::getInstance().init(log_filepath_,
        FileLogger::LogLevel::DEB, false);
    LOG_INFO() << "Log system initialized";
#endif
    lua_state_ = l;
    if (lua_state_ == nullptr) {
        return false;
    }
    LOG_INFO() << "Start, mainWnd_=" << (UINT)mainWnd_
        << ", lua_state_=" << lua_state_
        << ", tid=" << GetCurrentThreadId();

    CHookMgr<InjectorImpl>::InitHooks(HM_KEYBOARD);
    LOG_INFO() << "InitHooks, m_hKeyboardHook=" << m_hKeyboardHook;
    return has_lua_hook_sucessed();
}

void InjectorImpl::PeekDispatchMessage(const MSG* lpmsg, bool prev) {
    if (prev) {
        DispatchMessagePrev(lpmsg->hwnd, lpmsg->message, lpmsg->wParam, lpmsg->lParam, lpmsg->time, lpmsg->pt);
    } else {
        DispatchMessagePost(lpmsg->hwnd, lpmsg->message, lpmsg->wParam, lpmsg->lParam, lpmsg->time, lpmsg->pt);
    }
}


void InjectorImpl::DispatchMessagePrev(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam, DWORD time, POINT pt) {
    if (message == WM_DESTROY && hwnd == mainWnd_) {
        UnregisterHotKey(mainWnd_, m_nHotKeyId);
    }
}

void InjectorImpl::DispatchMessagePost(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam, DWORD time, POINT pt) {
    CheckMainWindow(hwnd, message);
    if (message == WM_DELAYLUAMAIN) {
        init_lua_code_injected();
        CheatData data;
        data.env() = GetLuaEnvData();
        data.misc().read_config_file(config_filepath_.c_str());
        refresh_settings_lua_code(data);
    } else if (message == WM_NCLBUTTONDBLCLK && wParam == HTCAPTION && hwnd == mainWnd_) {
        PostMessage(hwnd, WM_DELAYSHOWDLG, 0, 0);
    } else if (message == WM_DELAYSHOWDLG) {
        ShowSettingDlg(hwnd);
    } else if (message == WM_DESTROY && hwnd == mainWnd_) {
        if (mDialogEx.IsWindow()) {
            mDialogEx.DestroyWindow();
        }
    }
}

void InjectorImpl::PeekTranslateMessageMessage(const MSG* lpmsg, bool prev) {
}


void InjectorImpl::init_lua_code_injected() {
    if (lua_state_ == nullptr || !has_lua_hook_sucessed()) {
        return;
    }
    if (init_lua_code_injected_) {
        return;
    }
    DisableStrictMode(lua_state_);
    std::string code = k_init_lua_code0;
    int lua_ret; std::string errmsg;
    std::tie(lua_ret, errmsg) = lua_dostring_ex(lua_state_, code.c_str());
    LOG_INFO() << "init_lua_code_injected0, lua_ret=" << lua_ret
        << ", errmsg=" << lua_ret;
    if (lua_ret == LUA_INIT_FAILED) {
        return;
    }
    if (lua_ret != LUA_OK) {
        return;
    }
    code = k_init_lua_code;
    std::tie(lua_ret, errmsg) = lua_dostring_ex(lua_state_, code.c_str());
    LOG_INFO() << "init_lua_code_injected, lua_ret=" << lua_ret
        << ", errmsg=" << lua_ret;
    if (lua_ret == LUA_INIT_FAILED) {
        return;
    }
    if (lua_ret != LUA_OK) {
        return;
    }
    init_lua_code_injected_ = true;
}

void InjectorImpl::refresh_settings_lua_code(CheatData& data) {
    if (lua_state_ == nullptr || !has_lua_hook_sucessed()) {
        return;
    }
    if (!init_lua_code_injected_) {
        return;
    }

    std::string code = k_update_lua_code;
    Common::string_replace(code, "$001", std::to_string(data.misc().jyqxz_trace_log()));
    Common::string_replace(code, "$002", std::to_string(data.misc().jyqxz_baoxi_dengji()));
    Common::string_replace(code, "$003", std::to_string(data.misc().jyqxz_baoxi_wugong()));
    Common::string_replace(code, "$004", std::to_string(data.misc().jyqxz_baoxi_maxvalue()));
    Common::string_replace(code, "$005", std::to_string(data.misc().jyqxz_adjust_wupin()));
    int lua_ret; std::string errmsg;
    std::tie(lua_ret, errmsg) = lua_dostring_ex(lua_state_, code.c_str());
    LOG_INFO() << "refresh_settings_lua_code, lua_ret=" << lua_ret
        << ", errmsg=" << lua_ret;
    if (lua_ret == LUA_INIT_FAILED) {
        return;
    }
    if (lua_ret != LUA_OK) {
        return;
    }
}

void InjectorImpl::refresh_person_lua_code(CheatData& data) {
    if (lua_state_ == nullptr || !has_lua_hook_sucessed()) {
        return;
    }
    if (!init_lua_code_injected_) {
        return;
    }
    PersonData& personData = data.person();
    if (personData.jyqxz_person_id() < 0) {
        return;
    }
    std::string code = k_update_person_data_code;

    Common::string_replace(code, "$000", std::to_string(personData.jyqxz_person_id()));
    Common::string_replace(code, "$100", std::to_string(personData.jyqxz_person_xiulian()));
    Common::string_replace(code, "$101", std::to_string(personData.jyqxz_person_wuchang()));
    auto wugongs = personData.jyqxz_person_sort_wugongs();
    for (size_t i = 0; i < wugongs.size(); i++) {
        std::string key = "$" + std::to_string(200 + i);
        Common::string_replace(code, key.c_str(), std::to_string(wugongs[i]));
    }
    int lua_ret; std::string errmsg;
    std::tie(lua_ret, errmsg) = lua_dostring_ex(lua_state_, code.c_str());
    LOG_INFO() << "refresh_person_lua_code, lua_ret=" << lua_ret
        << ", errmsg=" << lua_ret;
    if (lua_ret == LUA_INIT_FAILED) {
        return;
    }
    if (lua_ret != LUA_OK) {
        return;
    }
}


void InjectorImpl::OnLuaMainRun() {
    LOG_INFO() << "OnLuaMainRun, mainWnd_=" << (UINT)mainWnd_
        << ", IsWindow(mainWnd_)=" << IsWindow(mainWnd_);
    if (mainWnd_ != NULL && ::IsWindow(mainWnd_)) {
        PostMessage(mainWnd_, WM_DELAYLUAMAIN, 0, 0);
    } else {
        mainWnd_ = NULL;
    }
}

void InjectorImpl::CheckMainWindow(HWND hwnd, UINT message) {
    if (mainWnd_ != NULL && ::IsWindow(mainWnd_)) {
        return;
    }
    if (::IsWindow(hwnd)) {
        LOG_INFO() << "CheckMainWindow 0, mainWnd_=" << (UINT)mainWnd_
            << ", IsWindow(mainWnd_)=" << IsWindow(mainWnd_);
        char szClazz[256] = { 0 };
        char szCaption[256] = { 0 };
        ::GetClassNameA(hwnd, szClazz, 255);
        ::GetWindowTextA(hwnd, szCaption, 255);
        if (_stricmp(szClazz, "SDL_app") == 0 && _stricmp(szCaption, "JY_LDCR") == 0) {
            LOG_INFO() << "CheckMainWindow 1, mainWnd_=" << (UINT)mainWnd_
                << ", IsWindow(mainWnd_)=" << IsWindow(mainWnd_)
                << ", szCaption=" << szCaption
                << ", GetWindowLong()=" << ::GetWindowLong(hwnd, GWL_STYLE)
                ;
            mainWnd_ = hwnd;
            BOOL bRet = RegisterHotKey(mainWnd_, m_nHotKeyId, MOD_CONTROL | MOD_SHIFT, '+');
            LOG_INFO() << "CheckMainWindow 2, RegisterHotKey"
                       <<", result=" << bRet
                       ;
            PostMessage(mainWnd_, WM_DELAYLUAMAIN, 0, 0);
        }
    }
}

void InjectorImpl::ShowSettingDlg(HWND hwnd) {
    EnvData evData = GetLuaEnvData();
    if (!evData.is_valid_banben() || !evData.is_valid_status()) {
        return;
    }
    CompositeDialog& compositeCtrl = mDialogEx;
    if (!compositeCtrl.IsWindow()) {
        compositeCtrl.Create(mainWnd_);
    }
    if (compositeCtrl.IsWindowVisible()) {
        return;
    }
    if (compositeCtrl.IsWindow()) {
        compositeCtrl.UpdateUi(true);
        Common::CenterAndActivateChildWindow(compositeCtrl.m_hWnd, mainWnd_);
        return;
    }
}

LRESULT InjectorImpl::KeyboardProc_i(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode == HC_ACTION) {
        // 检查是否为按键按下消息 (WM_KEYDOWN 或 WM_SYSKEYDOWN)
            // 获取虚拟键码
        int vkCode = (int)wParam; // 对于 WH_KEYBOARD，wParam 是虚拟键码[4](@ref)
         // 判断按下的键是否是 A 键
        if (vkCode == 'O' || vkCode == 'o') { // 通常不区分大小写，但检查两者更稳妥
            // 检查 Ctrl 和 Shift 键的状态
            bool isCtrlPressed = (GetKeyState(VK_CONTROL) & 0x8000) != 0;
            bool isShiftPressed = (GetKeyState(VK_SHIFT) & 0x8000) != 0;
            bool isCodePressed = (GetKeyState(vkCode) & 0x8000) != 0;

            // 如果 Ctrl 和 Shift 都处于按下状态
            if (isCtrlPressed && isShiftPressed && isCodePressed) {
                // 执行自定义操作，例如弹出提示
                LOG_INFO() << "KeyboardProc_i, vkCode=" << vkCode << ", ok";
                PostMessage(mainWnd_, WM_DELAYSHOWDLG, 0, 0);
                // 返回 1 表示已处理此消息，阻止其继续传递[3](@ref)
                return 1;
            }
        }
        if (vkCode == VK_ESCAPE) {
            if (mDialogEx.IsWindow() && mDialogEx.IsWindowVisible()) {
                mDialogEx.PostMessage(WM_CLOSE, 0, 0);
            }
        }
    }
    return CallNextHookEx(m_hKeyboardHook, nCode, wParam, lParam);
}

EnvData InjectorImpl::GetLuaEnvData() {
    EnvData result;
    if (CallLuaFunction(lua_state_, "Fucker_GetEnvData")) {
        if (lua_pcall_ex(lua_state_, 0, 1, 0) == LUA_OK) {
            if (lua_istable_ex(lua_state_, -1)) {
                orig_lua_getfield(lua_state_, -1, "BanBen");
                result.BanBen = (int)lua_tonumber_ex(lua_state_, -1);
                lua_pop_ex(lua_state_, 1);

                orig_lua_getfield(lua_state_, -1, "Status");
                result.Status = (int)lua_tonumber_ex(lua_state_, -1);
                lua_pop_ex(lua_state_, 1);

                orig_lua_getfield(lua_state_, -1, "WugongNum");
                result.WugongNum = (int)lua_tonumber_ex(lua_state_, -1);
                lua_pop_ex(lua_state_, 1);
            }
            lua_pop_ex(lua_state_, 1);
        }
    }
    LOG_INFO() << "InjectorImpl::GetLuaEnvData, result.banben=" 
               << result.BanBen << ", result.status=" << result.Status
               << ", result.WugongNum=" << result.WugongNum
               ;
    return result;
}

void InjectorImpl::GetPersonData(PersonData& personData) {
    auto& wugongs = personData.jyqxz_person_wugongs();
    wugongs.clear();
    if (CallLuaFunction(lua_state_, "Fucker_GetPersonData")) {
        orig_lua_pushinteger(lua_state_, personData.jyqxz_person_id());
        if (lua_pcall_ex(lua_state_, 1, 1, 0) == LUA_OK) {
            if (lua_istable_ex(lua_state_, -1)) {
                orig_lua_getfield(lua_state_, -1, "xlid");
                personData.jyqxz_person_xiulian() = (int)lua_tonumber_ex(lua_state_, -1);
                lua_pop_ex(lua_state_, 1);

                orig_lua_getfield(lua_state_, -1, "wuchang");
                personData.jyqxz_person_wuchang() = (int)lua_tonumber_ex(lua_state_, -1);
                lua_pop_ex(lua_state_, 1);

                for (int i = 1; i <= 10; i++) {
                    std::string key = "wugong" + std::to_string(i);
                    orig_lua_getfield(lua_state_, -1, key.c_str());
                    wugongs.push_back((int)lua_tonumber_ex(lua_state_, -1));
                    lua_pop_ex(lua_state_, 1);
                }
            }
            lua_pop_ex(lua_state_, 1);
        }
    }
    LOG_INFO() << "InjectorImpl::GetPersonData"
               << ", personData.jyqxz_person_id()=" << personData.jyqxz_person_id() 
               << ", personData.jyqxz_person_xiulian()=" << personData.jyqxz_person_xiulian()
               << ", personData.jyqxz_person_wuchang()=" << personData.jyqxz_person_wuchang()
               << ", wugongs.size()=" << wugongs.size()
               ;
}


void InjectorImpl::OnUiHide(CompositeDialog* caller) {
    MiscData md;
    md.read_config_file(config_filepath_.c_str());
    md.jyqxz_adjust_wupin() = 0;
    md.write_config_file(config_filepath_.c_str());
    ::SetFocus(mainWnd_);
}

void InjectorImpl::GetCheatData(CompositeDialog* caller, CheatData& cheatData) {
    cheatData.env() = GetLuaEnvData();
    cheatData.misc().read_config_file(config_filepath_.c_str());
    GetPersonData(cheatData.person());
}

void InjectorImpl::UpdateCheatData(CompositeDialog* caller, CheatData& cheatData) {
    cheatData.misc().write_config_file(config_filepath_.c_str());
    refresh_settings_lua_code(cheatData);
    refresh_person_lua_code(cheatData);
}
