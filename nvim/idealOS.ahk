; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\idealOS

files = % ""
. " README.md"

; MsgBox % files
Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (idealOS) Neovide

ExitApp
