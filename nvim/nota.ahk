; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\nota

files = % ""
. " README.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Nota) Neovide

ExitApp
