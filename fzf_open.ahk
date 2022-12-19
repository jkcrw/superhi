; Temporary workaround for starting an fzf search
; Jak Crow 2022/05/14

mode := A_Args[1]

if (mode == "start") {
    ; Summon WT and run `search`
    SendInput ^!+#-
    Sleep 50
    SendInput open aslauncher{Enter}
} else {
    ; Dismiss WT
    WinWait ahk_exe WindowsTerminal.exe
    Send ^!+#-
}

ExitApp
