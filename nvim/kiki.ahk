; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\kiki

files = % ""
. " q.md"
. " _journal\life.md"
. " _journal\lw.md"
. " software\swj.md"
. " software\osu.md"
. " software\tools.md"
. " software\org.md"

Run neovide.exe %files%  --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Kiki) Neovide

ExitApp
