; Advanced window management magic.
; Created: 2016/06/26
; Inspired by Andrew Moore's Advanced Window Snap (https://gist.github.com/AWMooreCO/1ef708055a11862ca9dc)

; ┌─────────────────────────────────────────────────────────────────────────────
; │ Global Window Snapping
; └─────────────────────────────────────────────────────────────────────────────
; Monitor Assignments
GetMonitorNum(name) {
  switch A_ComputerName {
    case "SEL":
      monitors := {"top_center": 2, "main_left": 4, "main_center": 1, "main_right": 3}
    case "X1":
      monitors := {"main_left": 2, "main_center": 1, "main_right": 3}
  }
  monitorNum := monitors[name]
  return monitorNum
}

; Keyboard Full-Screen Snaps
^!+#8::Snap("top_center", "full", "full")
^!+#5::Snap("main_center", "full", "full")
^!+#4::Snap("main_left", "full", "full")
^!+#6::Snap("main_right", "full", "full")

; Keyboard Half-Screen Snaps
^!+4::Snap("main_left", "left", "full")
^!+1::Snap("main_left", "right", "full")
^!+5::Snap("main_center", "left", "full")
^!+2::Snap("main_center", "right", "full")
^!+6::Snap("main_right", "left", "full")
^!+3::Snap("main_right", "right", "full")
^!+7::Snap("top_center", "left", "full")
^!+9::Snap("top_center", "right", "full")

; Mouse Half-Screen Snap
^!+#LButton::
  data := GetMouseMonitorData()
  monitor := data[1]
  regionH := data[2]
  Snap(monitor, regionH, "full")
Return

; Mouse Quarter-Screen Snap
^!+#RButton::
  data := GetMouseMonitorData()
  monitor := data[1]
  regionH := data[2]
  regionV := data[3]
  Snap(monitor, regionH, regionV)
Return

; Mouse Full-Screen Snap
^!+#MButton::
  data := GetMouseMonitorData()
  monitor := data[1]
  Snap(monitor, "full", "full")
Return

;┌─────────────────────────────────────────────────────────────────────────────
;│ AUTOMATIC WINDOW LAYOUTS
;└─────────────────────────────────────────────────────────────────────────────
^!#0::LayoutStandard()
^!#1::LayoutStenoPractice()
^!#2::LayoutKanken()
^!#3::LayoutTech()
^!#4::LayoutDiscreteMath()
^!#5::LayoutRead()
^!#6::LayoutStudy()
^!#F24::LayoutStenoKeyboard()

LayoutStandard() {
  Run wtp,, Hide
  Run "anki.cmd"
  Run "idea64.exe"
  Run "vivaldi.exe"
  Sleep 7500

  WinActivate \(SEL\) - Sublime Text
  Snap("main_left", "left", "full")

  WinActivate \(JiKi\) - Sublime Text
  Snap("main_left", "right", "full")

  WinActivate ahk_exe WindowsTerminal.exe
  Snap("top_center", "left", "bottom")

  WinActivate \(Sparrowhawk\) - Sublime Text
  Snap("top_center", "right", "full")

  WinActivate ahk_exe vivaldi.exe
  Snap("main_center", "left", "full")

  WinActivate _IJ
  Snap("main_center", "right", "full")

  WinActivate \(DV\) - Sublime Text
  Snap("main_right", "left", "full")

  WinActivate Jak - Anki
  Snap("main_right", "right", "full")
}

LayoutStenoPractice() {
  Return
}

LayoutKanken() {
  ; Run "C:\Scoop\apps\anki\current\anki.cmd"
  Run "https://kanji.jitenon.jp/"
  Sleep 1000

  WinActivate Jak - Anki
  Snap("main_center", "left", "full")
  WinActivate ahk_exe vivaldi.exe
  Snap("main_center", "right", "full")
  Return
}

LayoutTech() {
  Run "https://leetcode.com/jxcrw/"
  Run "https://leetcode.com/problemset/all/"
  ; Run "https://www.techinterviewhandbook.org/best-practice-questions"
  Run "https://gist.github.com/tykurtz/3548a31f673588c05c89f9ca42067bc4"
  Run "https://monkeytype.com"
  Run "C:\\~\\dev\\sphk\\Utilities\\steno-jig\\form.html"
  Run "idea64.exe" "C:\~\dev\dokugaku\pazuru\tools\_kb.py"
  Sleep 1000

  WinActivate ahk_exe vivaldi.exe
  Snap("main_center", "left", "full")
  WinActivate ahk_exe idea64.exe
  Snap("main_center", "right", "full")
  WinActivate \(DV\) - Sublime Text
  Snap("main_right", "left", "full")
  WinActivate Jak - Anki
  Snap("main_center", "right", "full")
  Return
}

LayoutDiscreteMath() {
  Run "https://blackboard.und.edu/ultra/courses/_124545_1/cl/outline"
  Run "C:\~\work\_school\osu\cs208"
  Run "C:\~\work\_school\osu\cs208\textbook.pdf"
  Sleep 1000
  Run "C:\~\work\_school\osu\Exercise Solutions.pdf"
  Sleep 1000
  Sleep 5000

  WinActivate ahk_exe vivaldi.exe
  Snap("main_left", "right", "full")

  WinActivate Discrete Math 3rd Edition
  Snap("main_center", "left", "full")

  WinActivate cs208
  Snap("top_center", "right", "bottom")

  WinActivate \(OSU\) Neovide
  Snap("main_center", "right", "full")

  WinActivate Exercise Solutions
  Snap("main_right", "left", "full")

  WinActivate Jak - Anki
  Snap("main_right", "right", "full")
  Sleep 1000

  Sleep 10000
  Run "https://blackboard.und.edu/ultra/courses/_124545_1/cl/outline"
  Return
}

LayoutRead() {
  Run "C:\scoop\apps\sioyek\current\sioyek.exe" "C:\~\archives\media\books\_wip\practical-vim.pdf"
  Run "autohotkey.exe" "C:\~\dev\superhi\LaunchToggle.ahk" "\(Neovim\) ahk_exe neovide.exe" "C:\~\dev\superhi\nvim\nvim.ahk",, Hide
  Sleep 1000
  Run "autohotkey.exe" "C:\~\dev\superhi\LaunchToggle.ahk" "\(Dokugaku\) ahk_exe neovide.exe" "C:\~\dev\superhi\nvim\dokugaku.ahk",, Hide
  Sleep 1000

  WinActivate ahk_exe sioyek.exe
  Snap("main_center", "left", "full")

  WinActivate \(Neovim\) Neovide
  Snap("main_center", "right", "full")

  WinActivate \(Dokugaku\) Neovide
  Snap("main_right", "left", "full")

  Return
}

LayoutStudy() {
  Run "autohotkey.exe" "C:\~\dev\superhi\LaunchToggle.ahk" "ahk_exe msedge.exe" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk",, Hide
  Sleep 1500
  Run "autohotkey.exe" "C:\~\dev\superhi\LaunchToggle.ahk" "\(Dokugaku\) ahk_exe neovide.exe" "C:\~\dev\superhi\nvim\dokugaku.ahk",, Hide
  Sleep 1500

  WinActivate ahk_exe msedge.exe
  Snap("main_center", "left", "full")

  WinActivate \(Dokugaku\) Neovide
  Snap("main_center", "right", "full")
  Sleep 250
  Send !u
  Sleep 250
  Send :e _dsa\complete-dsa-python\README.md{Enter}

  Return
}

LayoutStenoKeyboard() {
  if !WinExist("Keyboard Layout Editor") {
    Run "vivaldi.exe"
    Sleep 400
    Run http://www.keyboard-layout-editor.com/#/gists/e15f18924bc8a791d9ab9e7bb8ca9236
    Sleep 400
    Run http://www.keyboard-layout-editor.com/#/gists/454e13d2ab05ac0ba7275428fdf5051d
    Sleep 400
    Send ^1
    Sleep 400
    Send ^w
  }
  Return
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ ALWAYS ON TOP
;└─────────────────────────────────────────────────────────────────────────────
^!#a::AlwaysOnTop()

AlwaysOnTop() {
  WinGet, currentWindow, ID, A
  WinGet, ExStyle, ExStyle, ahk_id %currentWindow%
  if (ExStyle & 0x8) { ; 0x8 is WS_Ex_TOPMOST.
    Winset, AlwaysOnTop, off, ahk_id %currentWindow%
    SplashImage,, B1 FS12 CW272822 CTf94989, OFF always on top,,, Consolas
    Sleep, 1200
    SplashImage, Off
  } else {
    WinSet, AlwaysOnTop, on, ahk_id %currentWindow%
    SplashImage,, B1 FS12 CW272822 CTa6e22e, ON always on top,,, Consolas
    Sleep, 1200
    SplashImage, Off
  }
  Return
}

; ┌─────────────────────────────────────────────────────────────────────────────
; │ Helper Functions
; └─────────────────────────────────────────────────────────────────────────────
Snap(monitor, regionH, regionV) {
  if monitor is not integer
    monitor := GetMonitorNum(monitor) ; Snap command came from keyboard

  SysGet, mwa, MonitorWorkArea, %monitor% ; mwa = monitorWorkArea
  mwaWidth := mwaRight - mwaLeft
  mwaHeight := mwaBottom - mwaTop

  ; Calculate horizontal window geometry
  if (regionH == "left") {
    x := mwaLeft
    width := mwaWidth / 2
  } else if (regionH == "right") {
    x := mwaLeft + mwaWidth /2
    width := mwaWidth / 2
  } else if (regionH == "full") {
    x := mwaLeft
    width := mwaWidth
  }

  ; Calculate vertical window geometry
  if (regionV == "top") {
    y := mwaTop
    height := mwaHeight / 2
  } else if (regionV == "bottom") {
    y := mwaTop + mwaHeight /2
    height := mwaHeight / 2
  } else if (regionV == "full") {
    y := mwaTop
    height := mwaHeight
  }

  ; Per-client adjustments
  WinGetTitle, winTitle, A
  noAdjustmentClients := ["Sublime Text", "Vivaldi", "VS Code", "diagrams.net"]
  if Contains(winTitle, noAdjustmentClients) {
    ; Do nothing because no adjustments required
  } else {
    x := Round(x) - 9
    y := Round(y)
    width := Round(width) + 18
    height := Round(height) + 9
  }

  ; Snap!
  WinMove, A,, x, y, width, height
  Return
}


GetMouseMonitorData() {
  MouseGetPos, x, y
  SysGet, monitorCount, 80 ; Get the number of monitors

  Loop, %monitorCount% {
    SysGet, mwa, MonitorWorkArea, %A_Index%

    if (mwaLeft <= x && x < mwaRight) && (mwaTop <= y && y < mwaBottom) { ; If mouse within bounds of current monitor
      monitor := A_Index

      midH := mwaLeft + (mwaRight - mwaLeft) / 2
      midV := mwaTop + (mwaBottom - mwaTop) / 2

      regionH := x < midH ? "left" : "right"
      regionV := y > midV ? "bottom" : "top"
      break
    }
  }
  return [monitor, regionH, regionV]
}


Contains(string, substrings) {
  for key, substring in substrings {
    if InStr(string, substring) {
      return true
    }
  }
  return false
}
