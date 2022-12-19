; Open main Python scratch file in IntelliJ.
; Created: 2022/10/15

QuickOpen(app, file) {
  Run %app% %file%,,Hide
  Return
}

QuickOpen(A_Args[1], A_Args[2])

ExitApp
