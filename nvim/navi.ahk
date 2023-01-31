; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\arc\navi

files = % ""
. " README.md"
. " vim\practical-vim.md"
. " elec\pefi\README.md"
. " dsa\intro-to-algos\README.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Navi) Neovide

ExitApp
