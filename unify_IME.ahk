; Maintain Microsoft Japanese IME state across applications
; Jak Crow 2022

; AHK Setup
#SingleInstance force
#Persistent
DetectHiddenWindows On

; Global IME State and Monitor
global IME := 0
SetTimer, UnifyIME, 100 ; Unify every 100ms (negligible CPU cost)

; Helper Functions
ToggleIME() {
  SendInput !``
}

UnifyIME() {
  current := CheckIME()
  if (current != IME)
    ToggleIME()
}

CheckIME() {
  WinGet, winID, ID, A
  imeWin := DllCall("imm32\ImmGetDefaultIMEWnd", "UInt", winID)
  SendMessage, 0x283, 5, 0,, ahk_id %imeWin%
  Return ErrorLevel
}
