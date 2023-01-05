; Programs to start up when computer boots.
; Jak Crow 2018/10/28

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK SETUP
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#Hotstring O * ?

Sleep 30000
SplashImage,, x0 y0 b fs12, BOOTING STANDARD LOADOUT
Sleep, 2500
SplashImage, Off

ScriptSuspend("LMS.ahk", true)
ScriptSuspend("QwertyKeyboardShorcuts_P-Malt.ahk", true)
#Include Sublime Text Startup.ahk
Run "C:\Users\jak\Dropbox\Journals\Life HUD.xlsx"
Sleep 1000
Run "C:\Users\jak\Dropbox\Sparrowhawk\Steno Practice Manager.xlsx"
Sleep 1000
Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
Sleep 1000
Run "C:\Users\jak\Dropbox\Journals\2020 Life Journal.docx"
Sleep 1000

ScriptSuspend(ScriptName, SuspendOn)
{
    ; Get the HWND of the script's main window (which is usually hidden).
    dhw := A_DetectHiddenWindows
    DetectHiddenWindows On
    if scriptHWND := WinExist(ScriptName " ahk_class AutoHotkey")
    {
        ; This constant is defined in the AutoHotkey source code (resource.h):
        static ID_FILE_SUSPEND := 65404

        ; Get the menu bar.
        mainMenu := DllCall("GetMenu", "ptr", scriptHWND)
        ; Get the File menu.
        fileMenu := DllCall("GetSubMenu", "ptr", mainMenu, "int", 0)
        ; Get the state of the menu item.
        state := DllCall("GetMenuState", "ptr", fileMenu, "uint", ID_FILE_SUSPEND, "uint", 0)
        ; Get the checkmark flag.
        isSuspended := state >> 3 & 1
        ; Clean up.
        DllCall("CloseHandle", "ptr", fileMenu)
        DllCall("CloseHandle", "ptr", mainMenu)

        if (!SuspendOn != !isSuspended)
            SendMessage 0x111, ID_FILE_SUSPEND,,, ahk_id %scriptHWND%
        ; Otherwise, it's already in the right state.
    }
    DetectHiddenWindows %dhw%
}

ExitApp
