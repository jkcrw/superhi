; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\navi

files = % ""
. " README.md"
. " _dsa\intro-to-algos\README.md"
. " _elec\pefi\README.md"
. " vim\practical-vim.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Navi) Neovide

ExitApp
