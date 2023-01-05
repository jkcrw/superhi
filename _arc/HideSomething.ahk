; A stupid simple way to hide the clock so I can focus on my work.
; Jak Crow
; Created: 2016/11/19
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#Hotstring EndChars -( )[]{}:`;"\,.?!_=%
CoordMode, Screen

Gui, Add, Text,,
Gui, Show,,
WinMove, A,, 0, 0, 1000, 1000
Send !a
return
