; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\pazuru

files = % ""
. " README.md"
. " tools\_kb.py"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Pazuru) Neovide

ExitApp
