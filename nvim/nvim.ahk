; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\.sel2\nvim

files = % ""
. " init.lua"
. " lua\shizuka\opts.lua"
. " lua\shizuka\keys.lua"
. " lua\shizuka\keys-ext.lua"
. " lua\shizuka\plugman.lua"
. " lua\shizuka\color.lua"
. " _scratch\py.py"
. " _scratch\lua.lua"
. " _scratch\rs.rs"

; MsgBox % files
Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Neovim) Neovide

ExitApp
