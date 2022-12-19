; Quick and dirty script for launch-toggling Plover.
; Jak Crow
; Created: 2017/08/14

DetectHiddenWindows On
CoordMode, Mouse, Screen

plover_exe := "C:\~\dev\sphk\sphk\.bin\windows\plover.exe"

if WinExist("Plover ahk_class Qt5152QWindowIcon") {
    ; MsgBox Plover running
    Run %plover_exe% -s plover_send_command quit,,Hide
} else if !WinExist("Plover ahk_class Qt5152QWindowIcon") {
    ; MsgBox Plover not running
    SplashImage,, B1 FS12 CW272822 CTaeea00, Plover :),,, Consolas
    Run %plover_exe%
    Sleep, 1000
    SplashImage, Off
}
ExitApp
