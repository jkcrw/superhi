; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\superhi

files = % ""
. " main.ahk"
. " keys.ahk"
. " win.ahk"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Superhi) Neovide

ExitApp
