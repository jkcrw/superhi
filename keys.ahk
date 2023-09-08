; A collection of magical utilities for accelerating human-computer interaction.
; Jak Crow
; Created: 2015/11/26

;┌─────────────────────────────────────────────────────────────────────────────
;│ SYSTEM-WIDE KEYBOARD SHORTCUTS
;└─────────────────────────────────────────────────────────────────────────────
; Launch Applications
^!+#e::Run "C:\Windows\explorer.exe"
^!+x::Send ^+#2 ; Open terminal as admin
^!+#x:: ; LaunchToggle Terminal
  if WinExist("ahk_exe WindowsTerminal.exe") {
    Send ^!+#-
  } else {
    Run wtp,,Hide
    ; WinWait ahk_exe WindowsTerminal.exe
    ; Sleep 300
    ; WinActivate
    ; Snap(main_center, "left", "bottom")
    ; Sleep 100
    ; Send {F10}
  }
Return

F13::Run "launchtoggle_plover.ahk"
^!+#F15::Send ^!+p ; Summon KeePass
; ^!#e::Run "start_sublime.ahk"
^PrintScreen::Send #+s ; Take screenshot of selected region
^!+#Launch_App2::Run "https://calendar.google.com"
^!+#p::Return ; Placeholder so PowerPoint doesn't launch
^!+#y::Return ; Placeholder so Yammer doesn't launch
^!+#n::Return ; Placeholder so OneNote doesn't launch

Launch_App2::LaunchToggleApp("電卓 ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe", "calc.exe")
#IfWinActive 電卓 ahk_exe ApplicationFrameHost.exe
  Enter::
    Send {Enter}^c
    Return
#IfWinActive

LaunchToggleApp(winTitle, command) {
  if WinActive(winTitle) {
    WinMinimize
  } else if WinExist(winTitle) {
    WinActivate
  } else if !WinExist(winTitle) {
    Run %command%
  }
  Return
}

; Hotkeys
^!+#`::
  Sleep 50
  IME := !IME
  ToggleIME()
Return

; Universal window/client management
^!+#q:: ; Close application
#q::Send !{F4}

; ^!#F14::
;   WinSet, Transparent, 150, A
;   Sleep, 2000
;   WinSet, Transparent, OFF, A
;   Return

^!#F14::
 WinSet, Style, -0xC00000, A
 Return

^!#Down::Send #m ; Minimize all open windows
^!#Up::Send #+m ; Restore minimize-alled windows
^!+#Down::Send #{Down} ; Minimize current window
^!+#Up::Send #{Up} ; Maximize current window

; Tabbed Clients
^!+#t::Send ^t ; New tab
^!+#w::Send ^{F4} ; Close tab
^!+#Right::Send ^{Tab} ; Next tab
^!+#Left::Send ^+{Tab} ; Previous tab

^!+Tab::Send {Tab} ; Just tab key
Capslock::Tab ; Just tab key
^!+#F20::Click

;┌─────────────────────────────────────────────────────────────────────────────
;│ TEXT NAVIGATION/EDITING/SELECTION
;└─────────────────────────────────────────────────────────────────────────────
; Plover-transparent arrow keys
!Left::Send {Left}
!Right::Send {Right}
!Up::Send {Up}
!Down::Send {Down}
!End::Send {End}

; ^!+d::Send ^{Left}^+{Right} ; Expand selection to word
^!+#End::Send {Home}+{End} ; Expand selection to line (beginning to end)
^!+Home::Send {End}+{Home} ; Expand selection to line (end to beginning)
^!+#u::Send {End}+{Home}{Backspace} ; Delete to BOL

$^!+#F11:: ; Universal add line
  passthroughClients := ["idea64.exe", "neovide.exe"]
  WinGet, ahkexe, ProcessName, A
  if Contains(ahkexe, passthroughClients) {
    Sleep 30
    Send ^!+#{F11}
  } else {
    Send {End}{Enter}
  }
  Return

#Include toggle_case.ahk
^!+#F2::toggleCase(1)

; Context-sensitive paste
^!+#v::
  if WinActive("ahk_exe sublime_text.exe") {
    Send {Home}+{End}^+v ; Paste in place nicely
  } else if WinActive("ahk_exe idea64.exe") {
    Send {Home}+{End}^+v ; Paste in place nicely
  } else {
    Clipboard = %Clipboard%
    Send ^v ; Paste without formatting
  }
Return

;┌─────────────────────────────────────────────────────────────────────────────
;│ CLIENT-SPECIFIC KEYBOARD SHORTCUTS
;└─────────────────────────────────────────────────────────────────────────────
; Windows Explorer
#IfWinActive ahk_exe explorer.exe
  F4:: ; Open terminal in current/selected directory
    saved_clipboard := Clipboard
    Clipboard :=
    Send ^c
    ClipWait, 0.1
    if (Clipboard) {
      Clipboard := Clipboard
      Run wtp -d "%Clipboard%"
    } else {
      ; Send ^l^a^c
      ; ClipWait, 0.1
      path := GetExplorerPath()
      Run wtp -d "%path%",, Hide
    }
    Clipboard := saved_clipboard
  Return

  ^!+#F4:: ; Open neovim in current/selected directory
    saved_clipboard := Clipboard
    Clipboard :=
    Send ^c
    ClipWait, 0.1
    if (Clipboard) {
      Clipboard := Clipboard
      Run neovide.exe --multigrid "%Clipboard%"
    } else {
      ; Send ^l^a^c
      ; ClipWait, 0.1
      path := GetExplorerPath()
      Run neovide.exe --multigrid "%path%",, Hide
    }
    Clipboard := saved_clipboard
  Return

  ^!+#z:: ; Autozip/unzip files
    Send ^c
    ClipWait, 1
    file_path := Clipboard
    if (InStr(file_path, ".zip") or InStr(file_path, ".7z")) {
      file_name := StrSplit(file_path, "\").Pop()
      output_dir := StrReplace(file_path, file_name, "")
      Run 7z.exe e "%file_path%" -o"%output_dir%" -spf,, min
    } else {
      zip_name := file_path . ".zip"
      Run 7z.exe a "%zip_name%" "%file_path%",, min
    }
  Return

  ^!+#c:: ; Copy file path
    Clipboard :=
    Send ^c
    ClipWait, .1
    if (Clipboard)
      Clipboard := Clipboard
    else
      Clipboard := GetExplorerPath()
  Return
#IfWinActive

GetExplorerPath(hwnd=0){
  if (hwnd == 0) {
    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd == 0)
      explorerHwnd := WinExist("ahk_class CabinetWClass")
  }
  else
    explorerHwnd := WinExist("ahk_class CabinetWClass ahk_id " . hwnd)

  if (explorerHwnd) {
    for window in ComObjCreate("Shell.Application").Windows {
      try {
        if (window && window.hwnd && window.hwnd == explorerHwnd)
          return window.Document.Folder.Self.Path
      }
    }
  }
  return false
}

; Chromium-Based Browser
#IfWinActive ahk_exe vivaldi.exe
  ; Workarounds because Chromium-based browser stops responding to hotkeys
  ^t::Send ^t
  ^+t::Send ^+t
  ^w::Send ^w
  ^n::Send ^n
  ^+n::Send ^+n
  ^f::Send {F3}
  ^+a::Send ^+a
  ^!+#z::Send !z ; Enable/disable ZhongZhong
#IfWinActive

; Neovide
#IfWinActive ahk_exe neovide.exe
  ; App Control
  ; ^+n::Run neovide.exe
  ^!+#b::Send ^!{F7}

  ; Left Sidebar
  ^!+#f::Send ^!+#{F12}

  ; Text Editing/Navigation/Selection
  ^!+#d::Send ^+{F6} ; Duplicate line down
  ^!+d::Send ^+{F12} ; Duplicate line up

  ; Open in ST
  ^!+#r::Send !n

  ; Tiling/Paning
  ^+3::Send !b

  ; Tab Management
  ^!+w::Send !{F1}
  ^!#w::Send !u


  ; Debugging
  ; $!/::Send ^+e
  $!,::Send !y
  $!.::Send !x
  $!m::Send !n
  ; !F23::Send ^!#{F12}

  ; Version Control
  ^!g::Send ^+g
  ^!+#g::Send ^+g
  ^!s::Send ^!+#{F8}
  ^!a::Send ^+{F7}
  ^!d::Send !z
  ^!+#z::Send ^+{F4}
  ^!c::Send ^!#{F3}
  ^!b::Send ^+b
  ^!i::Send !s
  ^!#i::Send !t
  ^!o::Send ^+{F2}
  ^!+o::Send ^+{F8}
  ^!r::Send !{F12}
  !+a::Send ^!{F8}


  ; git Hunk movement
  $^WheelDown::
  $^,::
    Send !,
    Sleep 10
    Send zz
    Return
  $^WheelUp::
  $^.::
    Send !.
    Sleep 10
    Send zz
    Return
  ^m::Send ^+{F4}
  ^/::Send ^+a

  ^!+c::Send !p

  ^!+#F2::Send !{F11}


  ^!+#c::Send ^+{F5} ; Copy file path

  ^!v::Send !5 ; Paste Markdown link

  ^LButton::Send {Escape}gx

  ^SC029::Send ^+{F8}

  ^!+#F5::Send ^!#{F12}

  ; Increment range of numbers
  !+i::Send g^a

  ; $F14::Send ^!#{F5}
  ; ~F14 & F5::Send +{F5}

  ^!+#Tab::Send ^!#{F7}
  ^!+#Down::Send ^!#{F6}
  ^!+#Up::Send ^!#{F4}

  ; ^d::Send ^!+{F2}
  ^n::Send {Escape}.

  F14::return
  F14 up::
    if (A_PriorKey = "F14")
      Send ^!#{F5}
    return
  ~F14 & F5::Send +{F5}


  ^r::Send !e

  !F20::!v
  !F17::!v

  ^!+#u::Send ^u

  ; ^s::Send !s
  ^+Enter::Send O

  ; $^s::Send {Escape}^s
  !F15::Send !{Left}zz
  !F23::Send !{Right}zz
  ^!+F15::Send !{F7}
  ^!+#F23::Send !{F8}

  ; Comment in/out
  ^F17::Send !a
  ^F20::Send !a

  ; Jump back/forward
  ^o::Send ^!{F11}
  ^i::Send ^!{F10}

  ; Swap text
  ^!+#s::Send ^!{F9}

  ; Confirm
  ^Enter::
    Sleep 20
    Send ^s
    Sleep 20
    Send ^{F4}
    Return


  ; Focus current file in left sidebar tree
  ^!+f::Send !{F5}
  ^!+#F14::Send !{F5}
  ; MButton::
  ;   Click
  ;   Send {Escape}{Escape}{Escape}gd
  ;   Return
  ; ^!#b::Send ^+{F3}
  ; ; ^!#b::Send ^+b
  ; ^!+g::Send ^+{F3}
  ; ^F12::Return

#IfWinActive

; Sublime Text
#IfWinActive ahk_exe sublime_text.exe
  ^!+#Delete::Send ^+k ; Delete line
  ^!+#d::Send ^+d ; Duplicate line
  ^!+#Tab::Send ^{]} ; Indent
  +Tab::Send ^{[} ; Unindent
  ^!+#F15::Send ^{/} ; Comment
  ^F15::Send ^+{/} ; ^+Comment
  ^!+#n::Send ^!#n ; New view into current buffer
  ^!+#p::Send ^+n^!p ; Open recent workspace
  ^WheelUp::Send ^.
  ^WheelDown::Send ^,
  ^!+#r::
    Sleep 10
    Clipboard :=
    Send ^!#c
    ClipWait, 0.1
    Run "idea64.exe" %Clipboard%
    WinWait ahk_exe idea64.exe
    WinActivate ahk_exe idea64.exe
    Return
  ^!+#F3::
    Send ^d
    Send ^+f
    Send {Enter}
    Return
#IfWinActive

; IntelliJ IDEA
#IfWinActive ahk_exe idea64.exe
  ^!+#d::Send ^+d ; Duplicate line
  ^!+#Tab::Send ^{]} ; Indent
  +Tab::Send ^{[} ; Unindent

  ^!+#F15::Send ^{/} ; Comment/uncomment

  ^!+#Escape::Send ^!+#{F23} ; Close all toolwindows
  ^!+#c::Send ^+c ; Copy path
  ^!+#p::Send ^!p ; Open recent workspace
  ^+f:: ; Always search in whole project
    Send ^+f
    Sleep 50
    Send !p
    Return
  ^!+#r::
    Clipboard :=
    Send ^+c
    ClipWait, 0.1
    path := Clipboard
    Sleep 10
    Clipboard :=
    Send ^g^c
    ClipWait, 0.1
    Send {Escape}
    line_col := Clipboard
    full_path := path . ":" . line_col
    Run "subl.exe" "%full_path%",, Hide
    Return
  ^!+#n::Send ^!+#{F19} ; New view into current buffer
#IfWinActive

; Excel
#IfWinActive ahk_class XLMAIN
  ^!+#1::Send != ; Autosum cells
  ^F12::Return
#IfWinActive

; Excel
#IfWinActive ahk_class PPTFrameClass
  ^F12::Return
#IfWinActive

; Inkscape
#IfWinActive ahk_exe inkscape.exe
  ^!+#F1::Send ^!p ; Open settings
#IfWinActive

; GitHub
#IfWinActive jxcrw ahk_exe vivaldi.exe
  ^+p::
    Sleep 50
    SendInput ^k ; Command palette
    Return
#IfWinActive

; Terminal
#IfWinActive ahk_exe WindowsTerminal.exe
  ^!+#u::Send ^u
  ^WheelUp::Send ^o
  ^WheelDown::Send ^i
  ^F12::Return
  MButton::Send ^{LButton}
  ^Enter::Send {Right}{Enter}
#IfWinActive

; Word
#IfWinActive ahk_exe WINWORD.EXE
  ^F12::Return
#IfWinActive

; Sioyek
#IfWinActive ahk_exe sioyek.exe
  WheelDown::Send {PgDn}
  WheelUp::Send {PgUp}
  ^F12::Return
#IfWinActive

;┌─────────────────────────────────────────────────────────────────────────────
;│ WORKFLOW AUTOMATION
;└─────────────────────────────────────────────────────────────────────────────
^!#q:: ; Jump to Todoist
  Sleep 50
  WinActivate, ahk_exe vivaldi.exe
  Send ^2
Return

^!+#a:: ; Google search
  Clipboard :=
  Send ^c
  Clipboard := StrReplace(Clipboard, A_Space, "+")
  ClipWait, 1
  Run http://www.google.com/search?q=%Clipboard%
Return

^!+a:: ; Google search with quotes
  Clipboard :=
  Send ^c
  Clipboard := StrReplace(Clipboard, A_Space, "+")
  ClipWait, 1
  Run http://www.google.com/search?q="""%Clipboard%"""
Return

^!+#m:: ; Quick-email
  WinActivate, ahk_exe vivaldi.exe
  Send ^1
  Sleep 50
  Send c
Return

^!#t:: ; Hide subtitles
  SplashImage,, B H330 W2600 Y1750 CW000000 CTf94989
  Input, user_input, L5, q
  SplashImage, Off
  Return

;┌─────────────────────────────────────────────────────────────────────────────
;│ SOKKI
;└─────────────────────────────────────────────────────────────────────────────
FastText(text) {
  ; Use clipboard to send hotstring text faster than the native hotstrings (good for long text).
  Clipboard :=
  Clipboard := text
  ClipWait
  Sleep 10
  Send ^v
  Return
}

FastTime(format) {
  FormatTime, my_time, L0x0409, %format%
  SendInput %my_time%
  Return
}

; Time and date expansions
:X:\xnw::FastTime("yyyy/MM/dd HH:mm:ss")
:X:\xdt::FastTime("yyyy/MM/dd")
:X:\xpdt::FastTime("(yyyy/MM/dd) ")
:X:\xddt::FastTime("yyyy-MM-dd")
:X:\xldt::FastTime("MMMM d, yyyy")
:X:\xwdt::FastTime("ddd MM/dd/yyyy")
:X:\xdyti::FastTime("1900/01/01 HH:mm:ss")
:X:\xnhti::FastTime("1900/01/02 HH:mm:ss")

; Salutations
:X:\xkr::FastText("Kindest regards,`n`nJak")
:X:\xbestr::FastText("Best regards,`n`nJak")
:X:\xbs::FastText("Best,`n`nJak")
:X:\xcr::FastText("Cheers,`n`nJak")
:X:\xlv::FastText("Love,`n`nJak")

; Misc
::\day:: ; Life Journal daily entry template
  Sleep 50
  FormatTime, current_datetime,, yyyy/MM/dd
  FastText(current_datetime . " TITLE")
  Send ^!3^+{Left}
  Return
::\mxlrw:: ; Life Journal monthly review template
  Sleep 50
  FormatTime, current_datetime,, yyyy/MM/dd
  Month := A_YYYY . A_MM
  Month += -1, D
  FormatTime, Month, %Month% L0x0409, MMMM yyyy
  FastText(current_datetime . " " . Month . " Month in Review`n")
  FastText("General:`nLife HUD Report Card`n`n")
  FastText(Month . " Task Log ()`n`n")
  FastText("Finances:`n")
  FastText("FI 1.0 progress and date: #% (+#%) | mmddyy (-# days)`n")
  FastText("FI 2.0 progress and date: #% (+#%) | mmddyy (-# days)`n")
  FastText("# years to bust (+# years)`n`n")
  FastText("Dev:`n")
  FastText(Month . " Dev Log ()`n`n")
  ; FastText("PAD Engineering:`n`n")
  ; FastText("AO.industries:`n`n")
  FastText("Goals from last month:`n`n")
  FastText("Goals for next month:`n")
  Return

; Code
:X:\xline::FastText("─────────────────────────────────────────────────────────────────────────────")
:X:\hyp::FastText("^!+#")
:X:\meh::FastText("^!+")
:X:\cag::FastText("^!#")
::\skj::
  FastText("┌─────────────────────────────────────────────────────────────────────────────`n"
       . "│ SECTION_NAME`n"
       . "└─────────────────────────────────────────────────────────────────────────────")
  Send +{Home}+{Up 2}^/ ; Comment it out
  Send {End}{Down}^+{Left} ; Highlight SECTION_NAME for editing
  Return

::\xnucd::
  FormatTime, current_datetime,, yyyy/MM/dd
  if WinActive(".*\.py.*") {
    FastText("#!/usr/bin/env python3`n"
        . """""""DESCRIPTION""""""")
    Send {Left 3}^+{Left}
  } else {
    FastText("DESCRIPTION`nCreated: " . current_datetime)
    Send +{Home}+{Up}^/ ; Comment it out
    Send {End}^+{Left} ; Highlight DESCRIPTION for editing
  }
  Return

::\xosunucd::
  FormatTime, current_datetime,, yyyy/MM/dd
  FastText("#!/usr/bin/env python3`n`n"
      . "# Author: Jak Crow`n"
      . "# GitHub: jxcrw`n"
      . "# Date: " . current_datetime . "`n"
      . "# Description: DESCRIPTION")
  Send ^+{Left}
  Return

::\xjson:: ; JSON entry
  Send +{Home}
  Sleep 30
  Send ^c
  Sleep 30
  entry := StrSplit(Clipboard, " ")
  key := entry[1]
  value := entry[2]
  entry := """" . key . """: """ . value . ""","
  Sleep 30
  FastText(entry)
  Return

; ┌─────────────────────────────────────────────────────────────────────────────
; │ Unorganized
; └─────────────────────────────────────────────────────────────────────────────
^#s:: ; Save clipboard to file
  Sleep 100
  Clipboard :=
  Send ^c
  ClipWait, 0.1
  DROPBOX := "C:\Users\" . A_UserName . "\Dropbox\"
  file := DROPBOX . "subs.txt"
  FileAppend, %Clipboard%`n, %file%
  SplashImage,, B1 FS12 CW272822 CTa6e22e, Copied :),,, Consolas
  Sleep, 1000
  SplashImage, Off
  Return

#s:: ; Save Rikaikun output to file
  Sleep 100
  Clipboard :=
  Send c
  ClipWait, 0.1
  DROPBOX := "C:\Users\" . A_UserName . "\Dropbox\"
  file := DROPBOX . "subs.txt"
  FileAppend, %Clipboard%`n, %file%
  SplashImage,, B1 FS12 CW272822 CTa6e22e, Copied :),,, Consolas
  Sleep, 1000
  SplashImage, Off
Return

#z:: ; Universal Google translate
  Sleep 100
  Clipboard :=
  Send ^c
  ClipWait, 1
  Run https://translate.google.com/?hl=ja&sl=auto&tl=en&text=%Clipboard%
  Return

#x:: ; Cloze text while reading in Sublime Text
  Send {{}
  Return

^#x:: ; Uncloze text while reading in Sublime Text
  Sleep 100
  Send ^+{Space}
  Clipboard :=
  Send ^c
  ClipWait, 1
  replaced := StrReplace(Clipboard, "{", "")
  replaced := StrReplace(replaced, "}", "")
  Clipboard := replaced
  Send ^v
  Return

#c:: ; Look up in MDBG Chinese dictionary
  Sleep 100
  Clipboard :=
  Send ^c
  ClipWait, 1
  Run https://www.mdbg.net/chinese/dictionary?page=worddict&wdrst=1&wdqb=%Clipboard%
  Return

^!+#b:: ; Target tag
  Sleep 100
  Clipboard :=
  Send ^c
  ClipWait, 1
  replaced := "<span class=""target"">" . Clipboard . "</span>"
  Clipboard := replaced
  Send ^v
  Return

#k::Run, bthprops.cpl

^!+#k::
  #Include connect_bt.ahk
  Return


; ┌─────────────────────────────────────────────────────────────────────────────
; │ Lifehud
; └─────────────────────────────────────────────────────────────────────────────
^!#s:: ; Mind
  Clipboard :=
  Run, "C:\~\dev\lifehud\tracker\mind.py", "C:\~\dev\lifehud", Hide
  ClipWait, 0.5
  result := Clipboard
  result := StrSplit(result, "_")
  message := result[1]
  code := result[2]

  SplashImage,, B1 FS12 CW1a1b26 CT%code%, %message%,,, Consolas
  Sleep, 3000
  SplashImage
  SplashImage, Off
  Return

^!#p:: ; Pool
  Clipboard :=
  Run, "C:\~\dev\lifehud\tracker\pool.py", "C:\~\dev\lifehud", Hide
  ClipWait, 0.5
  result := Clipboard
  result := StrSplit(result, "_")
  message := result[1]
  code := result[2]

  SplashImage,, B1 FS12 CW1a1b26 CT%code%, %message%,,, Consolas
  Sleep, 3000
  SplashImage
  SplashImage, Off
  Return

^!#c:: ; Work
  Clipboard :=
  Run, "C:\~\dev\lifehud\tracker\work.py", "C:\~\dev\lifehud", Hide
  ClipWait, 0.5
  result := Clipboard
  result := StrSplit(result, "_")
  message := result[1]
  code := result[2]

  SplashImage,, B1 FS12 CW1a1b26 CT%code%, %message%,,, Consolas
  Sleep, 3000
  SplashImage
  SplashImage, Off
  Return

^!#b:: ; Body
  Clipboard :=
  Run, "C:\~\dev\lifehud\tracker\body.py", "C:\~\dev\lifehud", Hide
  Run "subl.exe" "C:\Users\jak\Dropbox\lifehud\body.txt:1:29",, Hide
  ClipWait, 0.5
  result := Clipboard
  result := StrSplit(result, "_")
  message := result[1]
  code := result[2]

  SplashImage,, B1 FS12 CW1a1b26 CT%code%, %message%,,, Consolas
  Sleep, 3000
  SplashImage
  SplashImage, Off
  Return
