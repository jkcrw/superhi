; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\keyboards

files = % ""
; . " aodox\README.md"
; . " avrdude.md"
. " aodox\_firmware\keymaps\default\keymap.c"
. " aodox\_firmware\aodox.h"
. " aodox\_firmware\config.h"
. " aodox\_firmware\rules.mk"
. " aodox\_firmware\copy.py"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (Keyboards) Neovide

ExitApp
