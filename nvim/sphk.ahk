; Setup
pythonbase := ""
EnvSet, PYTHONUSERBASE, %pythonbase%

SetWorkingDir, C:\~\dev\sphk\sphk

files = % ""
. " README.md"
. " main.json"
. " do.json"
. " special.json"
. " toggles.json"
. " _sprO\rules.md"
. " _sprO\sprO.json"
. " _sprO\corpus.json"
. " C:\Users\jak\AppData\Local\plover\plover\plover.cfg"
. " C:\~\dev\sphk\Utilities\progress_stats.py"

Run neovide.exe %files% --multigrid
WinWait Neovide
WinSetTitle, Neovide, , (SPHK) Neovide

ExitApp
