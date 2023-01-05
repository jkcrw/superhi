; Search any highlighted text in the Glova J<>E dictionary.
; Single click to use whatever is currently on clipboard.
; Double click to double-left click at current mouse position and use resulting selection.
; Jak Crow 2015/11/26

; ; ---SETUP-------------------
; #SingleInstance force
; SetTitleMatchMode 2 ; A window's title can contain WinTitle anywhere inside it to be a match.
; ; ---------------------------

; ^!+F3:: ; Uncomment this line if you want to run this as a standalone script.
if key_presses > 0 ; SetTimer already started, so we log the keypress instead.
{
    key_presses += 1
    return
}
; Otherwise, this is the first press of a new series. Set count to 1 and start
; the timer:
key_presses = 1
SetTimer, QuickGlovaKey, %double_click_time% ; Wait for more presses within a 400 millisecond window.
return

QuickGlovaKey:
SetTimer, QuickGlovaKey, off
if key_presses = 1 ; The key was pressed once.
{
    QuickGlova()
}
else if key_presses = 2 ; The key was pressed twice.
{
    Click
    Sleep 10
    Click
    QuickGlova()
}
; Regardless of which action above was triggered, reset the count to
; prepare for the next series of presses:
key_presses = 0
return

QuickGlova()
    {
    Send ^c
    WinActivate, Firefox ; Let's look it up in Glova
    Sleep, 50
    Send ^5 ; Select my Glova tab in Firefox
    Sleep, 50
    Send ^a^v{Enter}
    Return
    }
