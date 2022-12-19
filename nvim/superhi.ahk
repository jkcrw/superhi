; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\superhi

files = % ""
. " main.ahk"
. " keyman.ahk"
. " winman.ahk"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Superhi) Neovide

ExitApp
