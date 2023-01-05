; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\navi

files = % ""
. " README.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Navi) Neovide

ExitApp
