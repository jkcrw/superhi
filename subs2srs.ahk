; SUBS2SRS Practice Assistant
; Manages Anki + mplayer windows to make practicing SUBS2SRS easier
; Jak Crow 2014/1/13

#SingleInstance force
SetTitleMatchMode 2

Sleep 1000
SoundSet 50

if !WinExist("Anki") {
    Run anki, C:\Program Files\Anki
    Sleep 3000
}

if WinExist("Anki") {
    Sleep 100
    WinActivate
    Sleep 100
    Send #{Right}
}

; ; Give user control back to Anki if MPlayer steals it
while 1 {
    Sleep 500
    if WinExist("mpv") {
        WinActivate, Anki
    }
}

Numpad0::r

NumPadDot::Send ^z

NumPad7::Send k

Numpad9::Send ^{Delete}

NumpadSub::Send {Enter}
NumpadAdd::Send 4

; Resize when user presses d to return to deck view in Anki
+#d::
    WinMaximize Anki
    Send d
    Return

+#q::
    Send !{F4}
    Sleep 20000
    Run "C:\Users\jak\Dropbox\Scripts\System Backup\Windows\Anki_quick_backup.bat"
    ExitApp
