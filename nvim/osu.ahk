; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\work\_training\osu\cs208

files = % ""
. " README.md"
. " exercises.md"
. " assignments\solution_template.md"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (OSU) Neovide

ExitApp
