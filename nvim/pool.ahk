; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\pool

files = % ""
. " README.md"
. " notes.md"

; MsgBox % files
Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Pool) Neovide

ExitApp
