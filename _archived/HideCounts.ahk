; A stupid simple way to hide the counts in Studio so I can focus on my work.
; Jak Crow
; Created: 2018/11/12

#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#Hotstring EndChars -( )[]{}:`;"\,.?!_=%
CoordMode, Screen

Gui, Add, Text,,
Gui, Show,, -
WinMove, A,, 3120, 2065, 700, 35
Send ^!#a
Return
