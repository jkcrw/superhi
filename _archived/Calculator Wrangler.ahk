; Calculator-wrangling demo for Dad.
; Jak Crow
; Created: 2019/06/07

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK SETUP
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
; SetTitleMatchMode RegEx
#Hotstring EndChars ( )[]{}:`;",.?!=%
CoordMode, Mouse, Screen

;┌─────────────────────────────────────────────────────────────────────────────
;│ Calculator wrangling
;└─────────────────────────────────────────────────────────────────────────────
^!c:: ; Press Ctrl+Alt+C to run the following code
    Run Calc
    WinWait, Calculator, , 1
    WinMove, 0, 0
    Return
