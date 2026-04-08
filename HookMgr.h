// HookMgr.h: interface for the CHookMgr class.
#pragma once

#define INITHOOK(hook, flag, type, function) \
{ \
	if (dwOptions & flag) \
		hook = SetWindowsHookEx(type, function, NULL, GetCurrentThreadId()); \
}

#define RELEASEHOOK(hook) \
{ \
	if (hook) \
		UnhookWindowsHookEx(hook); \
\
	hook = NULL; \
}



constexpr DWORD HM_CALLWNDPROC = 0x0001;
constexpr DWORD HM_CALLWNDPROCRET = 0x0002;
constexpr DWORD HM_CBT = 0x0004;
constexpr DWORD HM_FOREGROUNDIDLE = 0x0008;
constexpr DWORD HM_GETMESSAGE = 0x0010;
constexpr DWORD HM_KEYBOARD = 0x0020;
constexpr DWORD HM_MOUSE = 0x0040;
constexpr DWORD HM_MSGFILTER = 0x0080;
constexpr DWORD HM_SHELL = 0x0100;
constexpr DWORD HM_SYSMSGFILTER = 0x0200;

#ifndef HSHELL_APPCOMMAND
#define HSHELL_APPCOMMAND           12
#endif

template<class T>
class CHookMgr
{
public:
    virtual ~CHookMgr()
    {
        ReleaseHooks();
    }

public:
    BOOL InitHooks( DWORD dwOptions = HM_MOUSE )
    {
        ReleaseHooks(); // reset

        INITHOOK( m_hCallWndHook, HM_CALLWNDPROC, WH_CALLWNDPROC, CallWndProc );
        INITHOOK( m_hCallWndRetHook, HM_CALLWNDPROCRET, WH_CALLWNDPROCRET, CallWndRetProc );
        INITHOOK( m_hCbtHook, HM_CBT, WH_CBT, CbtProc );
        INITHOOK( m_hForegroundIdleHook, HM_FOREGROUNDIDLE, WH_FOREGROUNDIDLE, ForegroundIdleProc );
        INITHOOK( m_hGetMessageHook, HM_GETMESSAGE, WH_GETMESSAGE, GetMessageProc );
        INITHOOK( m_hKeyboardHook, HM_KEYBOARD, WH_KEYBOARD, KeyboardProc );
        INITHOOK( m_hMouseHook, HM_MOUSE, WH_MOUSE, MouseProc );
        INITHOOK( m_hMsgFilterHook, HM_MSGFILTER, WH_MSGFILTER, MsgFilterProc );
        INITHOOK( m_hShellHook, HM_SHELL, WH_SHELL, ShellProc );
        INITHOOK( m_hSysMsgFilterHook, HM_SYSMSGFILTER, WH_SYSMSGFILTER, SysMsgFilterProc );

        return TRUE;
    }

protected:
    void ReleaseHooks()
    {
        RELEASEHOOK( m_hCallWndHook );
        RELEASEHOOK( m_hCallWndRetHook );
        RELEASEHOOK( m_hCbtHook );
        RELEASEHOOK( m_hForegroundIdleHook );
        RELEASEHOOK( m_hGetMessageHook );
        RELEASEHOOK( m_hKeyboardHook );
        RELEASEHOOK( m_hMouseHook );
        RELEASEHOOK( m_hMsgFilterHook );
        RELEASEHOOK( m_hShellHook );
        RELEASEHOOK( m_hSysMsgFilterHook );
    }

protected:
    HHOOK m_hCallWndHook;
    HHOOK m_hCallWndRetHook;
    HHOOK m_hCbtHook;
    HHOOK m_hForegroundIdleHook;
    HHOOK m_hGetMessageHook;
    HHOOK m_hKeyboardHook;
    HHOOK m_hMouseHook;
    HHOOK m_hMsgFilterHook;
    HHOOK m_hShellHook;
    HHOOK m_hSysMsgFilterHook;

protected:

    CHookMgr() // cannot instanciate one of these directly
    {
        m_hCallWndHook = NULL;
        m_hCallWndRetHook = NULL;
        m_hCbtHook = NULL;
        m_hForegroundIdleHook = NULL;
        m_hGetMessageHook = NULL;
        m_hKeyboardHook = NULL;
        m_hMouseHook = NULL;
        m_hMsgFilterHook = NULL;
        m_hShellHook = NULL;
        m_hSysMsgFilterHook = NULL;
    }

    // derived classes override whatever they need
    virtual LRESULT OnCallWndProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT OnCallWndRetProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT CbtProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT ForegroundIdleProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT GetMessageProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT KeyboardProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT SysMsgFilterProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT ShellProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT MsgFilterProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
    }
    virtual LRESULT MouseProc_i( int nCode, WPARAM wParam, LPARAM lParam )
    {
        //ATLASSERT ( 0 );
        return 1L ;
        /*
        T *pThis = static_cast<T *>(this);
        LRESULT result = 0;
        MOUSEHOOKSTRUCT* p = (MOUSEHOOKSTRUCT*)lParam;

        switch(wParam)
        {
        case WM_LBUTTONDOWN:
        case WM_LBUTTONUP:
        case WM_MOUSEMOVE:
        	{
        		HWND hWnd = pThis->m_hWnd;
        		if( hWnd != p->hwnd )
        		{
        			POINT pt = p->pt;
        			ScreenToClient( hWnd , &pt );

        			SendMessage( hWnd, wParam, 0 , MAKELPARAM(pt.x,pt.y) );
        		}
        	}
        	break;
        default :
        	break;

        }
        return CallNextHookEx(m_hMouseHook, nCode, wParam, lParam);
        */

    }


    // global app hooks
    // WH_CALLWNDPROC
    static LRESULT CALLBACK CallWndProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->OnCallWndProc_i( nCode, wParam, lParam );
    }

    // WH_CALLWNDRETPROC
    static LRESULT CALLBACK CallWndRetProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->OnCallWndRetProc_i( nCode, wParam, lParam );
    }

    // WH_CBT
    static LRESULT CALLBACK CbtProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->CbtProc_i( nCode, wParam, lParam );
    }

    // HM_FOREGROUNDIDLE
    static LRESULT CALLBACK ForegroundIdleProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->ForegroundIdleProc_i( nCode, wParam, lParam );
    }

    // WH_GETMESSAGE
    static LRESULT CALLBACK GetMessageProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->GetMessageProc_i( nCode, wParam, lParam );
    }

    // WH_KEYBOARD
    static LRESULT CALLBACK KeyboardProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->KeyboardProc_i( nCode, wParam, lParam );
    }

    // WH_MOUSE
    static LRESULT CALLBACK MouseProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->MouseProc_i( nCode, wParam, lParam );
    }

    // WH_MSGFILTER
    static LRESULT CALLBACK MsgFilterProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->MsgFilterProc_i( nCode, wParam, lParam );
    }

    // WH_SHELL
    static LRESULT CALLBACK ShellProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->ShellProc_i( nCode, wParam, lParam );
    }

    // WH_SYSMSGFILTER
    static LRESULT CALLBACK SysMsgFilterProc( int nCode, WPARAM wParam, LPARAM lParam )
    {
        return T::Get()->SysMsgFilterProc_i( nCode, wParam, lParam );
    }

};


