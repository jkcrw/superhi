; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\crow

files = % ""
. " q.md"
. " _jnl\life.md"
. " _jnl\lw.md"
. " software\swj.md"
. " software\osu.md"
. " software\tools.md"
. " software\org.md"

Run neovide.exe %files%  --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Crow) Neovide

ExitApp
