; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\lang\_rosita

files = % ""
. " README.md"

; MsgBox % files
Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Lang) Neovide

ExitApp
