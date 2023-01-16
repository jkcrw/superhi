; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\crow

files = % ""
. " Q.md"
. " _jnl\lw.md"
. " _jnl\jnl.md"
. " work\wj.md"
. " self\sj.md"
. " work\osu.md"
. " work\org.md"
. " work\tools.md"

Run neovide.exe %files%  --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Crow) Neovide

ExitApp
