#pragma once
#include "JZInjector.h"
#include "framework.h"
#include "CompositeControl.h"
#include "CompositeDialog.h"
#include "HookMgr.h"
#include "CheatData.h"

typedef int (__cdecl* LFN_luaL_loadstring)(lua_State* L, const char* s);
extern LFN_luaL_loadstring orig_luaL_loadstring ;

typedef int(__cdecl* LFN_lua_pcallk)(lua_State* L, int nargs, int nresults, int errfunc,
	int ctx, lua_CFunction k);
extern LFN_lua_pcallk orig_lua_pcallk ;
#define lua_pcall_ex(L,n,r,f)  orig_lua_pcallk(L, (n), (r), (f), 0, NULL)

typedef void (__cdecl* LFN_lua_settop)(lua_State* L, int idx);
extern LFN_lua_settop orig_lua_settop;
#define lua_pop_ex(L,n)		orig_lua_settop(L, -(n)-1)


typedef const char* (__cdecl *LFN_lua_tolstring)(lua_State* L, int idx, size_t* len);
extern LFN_lua_tolstring orig_lua_tolstring;
#define lua_tostring_ex(L,i) orig_lua_tolstring(L, (i), NULL)


typedef  lua_Number (__cdecl* LFN_lua_tonumberx) (lua_State* L, int idx, int* isnum);
extern LFN_lua_tonumberx orig_lua_tonumberx;
#define lua_tonumber_ex(L,i) orig_lua_tonumberx(L, i, NULL)


typedef void (__cdecl* LFN_lua_rawgeti)(lua_State* L, int idx, int n);
extern LFN_lua_rawgeti orig_lua_rawgeti;

typedef const char* (__cdecl* LFN_lua_setupvalue)(lua_State* L, int funcindex, int n);
extern LFN_lua_setupvalue orig_lua_setupvalue;


typedef void (__cdecl* LFN_lua_createtable)(lua_State* L, int narr, int nrec);
extern LFN_lua_createtable orig_lua_createtable;

typedef int (__cdecl* LFN_lua_setmetatable)(lua_State* L, int objindex);
extern LFN_lua_setmetatable orig_lua_setmetatable;


typedef void (__cdecl* LFN_lua_getfield)(lua_State* L, int idx, const char* k);
extern LFN_lua_getfield orig_lua_getfield;

typedef int (__cdecl* LFN_lua_type)(lua_State* L, int idx);
extern LFN_lua_type orig_lua_type;
#define lua_isfunction_ex(L,n)	(orig_lua_type(L, (n)) == LUA_TFUNCTION)
#define lua_istable_ex(L,n)	(orig_lua_type(L, (n)) == LUA_TTABLE)
#define lua_islightuserdata_ex(L,n)	(orig_lua_type(L, (n)) == LUA_TLIGHTUSERDATA)
#define lua_isnil_ex(L,n)		(orig_lua_type(L, (n)) == LUA_TNIL)
#define lua_isboolean_ex(L,n)	(orig_lua_type(L, (n)) == LUA_TBOOLEAN)
#define lua_isthread_ex(L,n)	(orig_lua_type(L, (n)) == LUA_TTHREAD)
#define lua_isnone_ex(L,n)		(orig_lua_type(L, (n)) == LUA_TNONE)
#define lua_isnoneornil_ex(L, n)	(orig_lua_type(L, (n)) <= 0)





#define lua_pushglobaltable_ex(L)  \
	orig_lua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_GLOBALS)


#define lua_newtable_ex(L) orig_lua_createtable(L, 0, 0)

typedef void (__cdecl* LFN_lua_getglobal)(lua_State* L, const char* var);
extern LFN_lua_getglobal orig_lua_getglobal;

typedef void (__cdecl* LFN_lua_getglobal)(lua_State* L, const char* var);


typedef void (__cdecl* LFN_lua_pushinteger)(lua_State* L, lua_Integer n);
extern LFN_lua_pushinteger orig_lua_pushinteger;


class InjectorImpl : 
	public CHookMgr<InjectorImpl>,
	public CompositeDialog::Delegate
{

private:
	InjectorImpl() = default;
public:
	~InjectorImpl() = default;

public:
	static InjectorImpl* Get();
	void Init(HINSTANCE hInst);
	bool Start(lua_State* l);
	void OnLuaMainRun();

public:
	void PeekDispatchMessage(const MSG* lpmsg, bool prev);
	void PeekTranslateMessageMessage(const MSG* lpmsg, bool prev);

public:
	LRESULT KeyboardProc_i(int nCode, WPARAM wParam, LPARAM lParam) override;

private:
	void DispatchMessagePrev(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam, DWORD time, POINT pt);
	void DispatchMessagePost(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam, DWORD time, POINT pt);

	void CheckMainWindow(HWND hwnd, UINT message);
	void ShowSettingDlg(HWND hwnd);

private:
	void init_lua_code_injected();
	void refresh_settings_lua_code(CheatData& data);
	void refresh_person_lua_code(CheatData& data);

	EnvData GetLuaEnvData();
	void GetPersonData(PersonData& personData);

//CompositeDialog::Delegate
private:
	void OnUiHide(CompositeDialog* caller) override;
	void GetCheatData(CompositeDialog* caller, CheatData& cheatData) override;
	void UpdateCheatData(CompositeDialog* caller, CheatData& cheatData) override;

private:
	lua_State* lua_state_ = nullptr;
	bool init_lua_code_injected_ = false;

	std::string exe_path_;
	std::string config_filepath_;
	std::string log_filepath_;

	HWND mainWnd_ = NULL;
	HINSTANCE hInst_;
	CCompositeControl mDialog;
	CompositeDialog mDialogEx;
	int m_nHotKeyId = 0x7FFFFFAA;

};

extern const char* k_init_lua_code;
extern const char* k_update_lua_code;
extern const char* k_update_person_data_code;


//gongji, CC.PersonAttribMax["\185\165\187\247\193\166"]
//fangyu, CC.PersonAttribMax["\183\192\211\249\193\166"]
//qinggong, CC.PersonAttribMax["\199\225\185\166"]
//yiliao, CC.PersonAttribMax["\210\189\193\198\196\220\193\166"]
//yongdu, CC.PersonAttribMax["\211\195\182\190\196\220\193\166"]
//jiedu, CC.PersonAttribMax["\189\226\182\190\196\220\193\166"]
//quanzhang, CC.PersonAttribMax["\200\173\213\198\185\166\183\242"]
//yujian, CC.PersonAttribMax["\211\249\189\163\196\220\193\166"]
//shuadao, CC.PersonAttribMax["\203\163\181\182\188\188\199\201"]
//teshu, CC.PersonAttribMax["\204\216\202\226\177\248\198\247"]
//anqi, CC.PersonAttribMax["\176\181\198\247\188\188\199\201"]

