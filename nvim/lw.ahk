;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK SETUP
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
SetTitleMatchMode RegEx
#InstallKeybdHook
#InstallMouseHook
#Persistent
CoordMode, Mouse, Screen

SetWorkingDir, C:\~\archives\jiki

Run neovide.exe _journals\lw.md --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Jiki) Neovide

ExitApp
