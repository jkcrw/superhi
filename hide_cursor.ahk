; Hide idle mouse cursor

; ┌─────────────────────────────────────────────────────────────────────────────
; │ AHK Setup
; └─────────────────────────────────────────────────────────────────────────────
#SingleInstance force
#Persistent
DetectHiddenWindows On


; ┌─────────────────────────────────────────────────────────────────────────────
; │ Main
; └─────────────────────────────────────────────────────────────────────────────
global CURSOR := 1
SetTimer, CheckIdle, 100

CheckIdle() {
  if (A_TimeIdleMouse > 25000) {
    if CURSOR
      SystemCursor(CURSOR := !CURSOR)
  } else if !CURSOR
    SystemCursor(CURSOR := !CURSOR)
}

SystemCursor(OnOff=1) {
  if (OnOff == 1) {
     BlockInput MouseMoveOff
     DllCall("ShowCursor", Int,1)
  } else {
     MouseGetPos, , , hwnd
     Gui Cursor:+Owner%hwnd%
     BlockInput MouseMove
     DllCall("ShowCursor", Int,0)
  }
  Return
}

