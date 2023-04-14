; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\work\_training\osu\cs261

files = % ""
. " README.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (OSU) Neovide

ExitApp
