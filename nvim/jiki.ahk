; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\archives\jiki

files = % ""
. " q.md"
. " _journals\life.md"
. " _journals\lw.md"
. " software\swj.md"
. " software\osu.md"
. " software\tools.md"
. " software\org.md"

Run neovide.exe %files%  --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Jiki) Neovide

ExitApp
