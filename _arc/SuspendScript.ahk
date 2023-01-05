; Suspend an AHK script. Previously part of TogglePlover.ahk.
; Jak Crow
; Created: 2020/02/05

ScriptSuspend(ScriptName, SuspendOn) {
    ; Get the HWND of the script's main window (which is usually hidden).
    dhw := A_DetectHiddenWindows
    DetectHiddenWindows On
    if scriptHWND := WinExist(ScriptName " ahk_class AutoHotkey") {
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
