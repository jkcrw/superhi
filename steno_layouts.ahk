; Open some Chrome windows with my steno layouts.
; Jak Crow
; Created: 2017/11/03

if !WinExist("Keyboard Layout Editor") {
  Run "vivaldi.exe"
  Sleep 400
  Run http://www.keyboard-layout-editor.com/#/gists/454e13d2ab05ac0ba7275428fdf5051d
  Sleep 400
  Run http://www.keyboard-layout-editor.com/#/gists/e15f18924bc8a791d9ab9e7bb8ca9236
}

ExitApp
