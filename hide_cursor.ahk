; Hide idle mouse cursor

; ┌─────────────────────────────────────────────────────────────────────────────
; │ AHK Setup
; └─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#Hotstring EndChars ( )[]{}:`;",.?!=%$
CoordMode, Mouse, Screen
DetectHiddenWindows On
FileEncoding, UTF-8
SetWinDelay, 0
#Hotstring O * ?


; ┌─────────────────────────────────────────────────────────────────────────────
; │ Main
; └─────────────────────────────────────────────────────────────────────────────
Status := 1
SetTimer, CheckIdle, 1000
return

CheckIdle:
  if (A_TimeIdleMouse > 5000)
  {
    if Status
      SystemCursor(Status := !Status)
  }
  else if !Status
    SystemCursor(Status := !Status)
return

SystemCursor(OnOff=1) {
  if (OnOff == 1)
  {
     BlockInput MouseMoveOff
     DllCall("ShowCursor", Int,1)
  }
  else
  {
     MouseGetPos, , , hwnd
     Gui Cursor:+Owner%hwnd%
     BlockInput MouseMove
     DllCall("ShowCursor", Int,0)
  }
}

