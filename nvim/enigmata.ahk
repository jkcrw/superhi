; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\enigmata

files = % ""
. " README.md"
. " tools\_kb.py"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Enigmata) Neovide

ExitApp
