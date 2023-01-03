; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\_lgx\scratch

files = % ""
. " md.md"
. " py.py"
. " ahk.ahk"
. " zsh.zsh"
. " lua.lua"
. " rs.rs"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Scratch) Neovide

ExitApp
