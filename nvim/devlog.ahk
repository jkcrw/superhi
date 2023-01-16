; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\devlog

files = % ""
. " devlog.py"
. " temp.md"
. " date.txt"

Run neovide.exe %files%  --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Devlog) Neovide

ExitApp
