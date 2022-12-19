; Map keys on Razer Naga mouse.
; Jak Crow
; Created: 2015/11/26

; Mouse Button Map
; Physical mouse:
; B1  B2  B3
; B4  B5  B6
; B7  B8  B9
; B10 B11 B12
; LeftWheel RightWheel Forward Back

; TODO: Organize together into Keyboard Magic and rename HCI Magic

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK Setup
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode 2
CoordMode, Mouse, Screen

;┌─────────────────────────────────────────────────────────────────────────────
;│ Naga Map
;└─────────────────────────────────────────────────────────────────────────────
; B1: Copy
^+<#h::Send ^c

; B2: Quick Google
^+<#a::
Send ^c
ClipWait, 1
Run http://www.google.com/search?q=%clipboard%
Return

; B3: Search current selection in ALC and weblio dictionaries
^+<#q::
^!+q::
Sleep 50
Sleep 100
Clipboard =
Send ^c
ClipWait 1
WinActivate, Chrome
Sleep 50
Run https://eow.alc.co.jp/search?q=%clipboard%
Sleep 50
Run https://ejje.weblio.jp/content/%clipboard%
Return

; B4: Paste
^+<#x::Send ^v

; B5: Quick-add term in SDL Trados Studio.
^+<#s::Send ^+{F2}

; B6: Code tag.
^+<#w::Send ^+k

; B7: Cut
^+<#c::Send ^x

; B8: Subscript (in Trados Studio)
^+<#d::
^!+d::Send ^{=}

; B9: Superscript (in Trados Studio)
^+<#e::
^!+e::Send ^+{=}

; B10: Temp hack for some current problem you are facing
^+<#v::
^!+v::TEMP_HACK()

; B11: Search for clipboard + "AZ Lyrics"
^+<#f::
Sleep 100
Clipboard :=
Send ^c
ClipWait, 1
search_string := StrReplace(Clipboard, "`r`n", A_Space) . " AZ lyrics"
Run http://www.google.com/search?q=%search_string%
Return

; B12: Play/Pause media
^+<#r::Send {Media_Play_Pause}

; LeftWheel: Previous tab in tabbed clients
^+<#b::Send ^+{Tab}

; RightWheel: Next tab in tabbed clients
^+<#g::Send ^{Tab}

; Forward: Back (in web browsers)
^+<#t::Send !{Left}

; Back: Forward (in web browsers)
^+<#l::Send !{Right}

;┌─────────────────────────────────────────────────────────────────────────────
;│ Functions
;└─────────────────────────────────────────────────────────────────────────────
TEMP_HACK() {
    Return
}

PCBNEW_AUTOPLACE() {
    Sleep 100
    Clipboard =
    Send e
    Sleep 750
    Send ^c
    Sleep 100
    xpos := Clipboard
    Clipboard = 
    Send {Tab}
    Send ^c
    Clipwait 1
    ypos := Clipboard
    Send {Escape}
    KeyWait, LButton, D
    Sleep 1500
    WinActivate, Pcbnew
    MouseMove 170, -2414
    Send e
    Sleep 1000
    Click 2030, -1267
    Send ^a
    Send % xpos
    Sleep 25
    Send {Tab}
    Sleep 25
    Send % ypos
    Sleep 25
    Send {Tab}
    Sleep 25
    Send 211.0 ; rotation
    Send {Enter}
    Return
}
