; Cast the various HCI magics.
; Created: 2015/11/26

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
; │ Load Everything Up
; └─────────────────────────────────────────────────────────────────────────────
#Include unify_IME.ahk
#Include hide_cursor.ahk
#Include win.ahk
#Include keys.ahk
#Include cagdrag.ahk
#Include mouse.ahk

^!+#Space::Reload
^!+#PgUp::ExitApp
