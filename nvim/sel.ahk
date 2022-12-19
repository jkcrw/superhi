; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\.sel2

files = % ""
. " README.md"
. " zsh\.zshrc"
. " zsh\do.zsh"
. " zsh\keys.zsh"
. " cron.tab"
. " windows-terminal\wt.json"
. " git\.gitconfig"
. " git\.gitignore_global"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (SEL) Neovide

ExitApp
