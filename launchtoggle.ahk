; LaunchToggle the specified app
; Jak Crow
; Created: 2022/05/02

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK SETUP
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#InstallKeybdHook
#InstallMouseHook
#Persistent

; for n, param in A_Args {
;     MsgBox Parameter number %n% is %param%
; }


LaunchToggleApp(winTitle, command) {
    if WinActive(winTitle) {
        WinMinimize
    } else if WinExist(winTitle) {
        WinActivate
    } else if !WinExist(winTitle) {
        Run %command%
    }
    Return
}

; LaunchToggleApp("(Scratch) ahk_class PX_WINDOW_CLASS ahk_exe sublime_text.exe", "C:\Users\jak\Dropbox\ST\Workspaces\Scratch.sublime-workspace")
LaunchToggleApp(A_Args[1], A_Args[2])

ExitApp
