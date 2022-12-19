; Text-related utilities for navigation, selection, etc.
; Jak Crow
; Created: 2016/10/22
;┌─────────────────────────────────────────────────────────────────────────────
;│ REVISION HISTORY
;└─────────────────────────────────────────────────────────────────────────────
; 2016/10/26
; - Added rudimentary support for expand selection to word/line.

; 2016/10/22
; - Added support for system-wide case toggling.

;┌─────────────────────────────────────────────────────────────────────────────
;│ NAVIGATION/EDITING
;│ Quickly navigate/select/edit text (like Ctrl(+Shift)+Arrow keys but faster).
;└─────────────────────────────────────────────────────────────────────────────
^!+Right::
    Send ^+{Right 2}
    Return
^!+Left::
    Send ^+{Left 2}
    Return
^!Right::
    Send ^{Right 2}
    Return
^!Left::
    Send ^{Left 2}
    Return
!Left::Send {Left}
!Right::Send {Right}
!Up::Send {Up}
!Down::Send {Down}
^!z::
    Send ^{z 2}
    Return
; ^!Backspace::
;     Send ^{Backspace 2}
;     Return

;┌─────────────────────────────────────────────────────────────────────────────
;│ SELECTION
;│ Advanced selection methods.
;└─────────────────────────────────────────────────────────────────────────────
^!+#l:: ; Expand selection to line.
    Send {Home}+{End}
    Send ^c
    Return
; #IfWinActive Sublime Text
; ^!+#l:: ; Expand selection to lines
;     Send ^l^c
;     Return
#IfWinActive
#IfWinActive ^((?!Sublime Text).)*$
^!+#d:: ; Expand selection to word
    Send ^{Left}^+{Right}
    Return
#IfWinActive

;┌─────────────────────────────────────────────────────────────────────────────
;│ WRAPPING
;│ System-wide quote/bracket/brace/paren wrap (like in Sublime text).
;└─────────────────────────────────────────────────────────────────────────────
; #IfWinActive ^((?!Sublime Text).)*$
; (::
;     WrapWith("(", ")")
;     Return

; [::
;     WrapWith("[", "]")
;     Return
; {::
;     WrapWith("{", "}")
;     Return
; "::
;     WrapWith("""", """")
;     Return
; #IfWinActive
; ; %::
; ;     WrapWith("%", "%")
; ;     Return

; WrapWith(pre_string, post_string) {
;     Sleep 25
;     SavedClip := Clipboard
;     Sleep 25
;     Clipboard := 
;     Send ^c
;     Sleep 25
;     if (Clipboard) {
;         Clipboard  := pre_string . Clipboard . post_string
;         Clipwait
;         Sleep 25
;         Send ^v
;     } else {
;         Send {%pre_string%}
;     }
;     Sleep 25
;     Clipboard := SavedClip
;     Return
; }
#IfWinActive ^((?!Sublime Text).)*$
^(::
    WrapWith("(", ")")
    Return

^[::
    WrapWith("[", "]")
    Return
^{::
    WrapWith("{", "}")
    Return
^"::
    WrapWith("""", """")
    Return
#IfWinActive
; %::
;     WrapWith("%", "%")
;     Return

WrapWith(pre_string, post_string) {
    Sleep 25
    SavedClip := Clipboard
    Sleep 25
    Clipboard := 
    Send ^c
    Sleep 25
    Clipboard := pre_string . Clipboard . post_string
    Clipwait
    Sleep 25
    Send ^v
    Sleep 25
    Clipboard := SavedClip
    Return
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ TOGGLE CASE
;│ System-wide case toggling.
;└─────────────────────────────────────────────────────────────────────────────
#IfWinActive ^((?!SDL Trados Studio).)*$
^!+#F3::
ToggleCase()
Return
#IfWinActive

ToggleCase() {
    Send ^c
    ; Sleep 90
    text := Clipboard
    count := WordCount(text)
    if (RegExMatch(text, "(?=.*[A-Z])(?=.*[a-z])")) { ; Title Case
        ; MsgBox Title Case
        text := ChangeCase(text, "U")
    } else if (RegExMatch(text, "[A-Z-,\.]")) { ; UPPER CASE
        ; MsgBox UPPER CASE
        text := ChangeCase(text, "L")
    } else if (RegExMatch(text, "[a-z-,\.]")) { ; lower case
        ; MsgBox lower case
        text := ChangeCase(text, "T")
    }
    Clipboard := text
    ClipWait
    Send ^v
    Send ^+{Left %count%}
}

WordCount(text) {
    text := Trim(text)
    Loop, Parse, text, %A_Space%, .
    {
        count := A_Index
    }
    Return count
}

ChangeCase(String,Type) { ; Type is S,I,U,L, or T
    If (Type="S") { ; Sentence case
     X = I,AHK,AutoHotkey ; Comma seperated list of words that should always be capitalized
     S := RegExReplace(RegExReplace(String, "(.*)", "$L{1}"), "(?<=[\.\!\?]\s|\n).|^.", "$U{0}")
     Loop Parse, X, `, ; Parse the exceptions
      S := RegExReplace(S,"i)\b" A_LoopField "\b", A_LoopField)
     Return S
    }
    If (Type="I") ; iNVERSE
    Return % RegExReplace(String, "([A-Z])|([a-z])", "$L1$U2")
    Return % RegExReplace(String, "(.*)", "$" Type "{1}")
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ MISC
;└─────────────────────────────────────────────────────────────────────────────
