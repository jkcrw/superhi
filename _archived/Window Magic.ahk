; Advanced window management.
; Jak Crow
; Created: 2016/06/26

ContainsAnyOf(string, substrings) {
    for key, substring in substrings {
        if InStr(string, substring)
            return true
    }
    return false
}

;┌─────────────────────────────────────────────────────────────────────────────
;│ ADVANCED WINDOW SNAP
;│ Inspired by Andrew Moore <andrew+github@awmoore.com>
;└─────────────────────────────────────────────────────────────────────────────
; Snap resizes and moves the active window to a given position.
; @param {int} monitorName           The monitor to move the active window to.
;                                    Expecting "top" or "bottom", otherwise assumes
;                                    window should span the "full" height of the monitor.
; @param {string} winPlaceVertical   The vertical placement of the active window.
;                                    Expecting "top" or "bottom", otherwise assumes
;                                    window should span the "full" height of theI monitor.
; @param {string} winPlaceHorizontal The horizontal placement of the active window.
;                                    Expecting "right" or "middle", otherwise assumes
;                                    window should be placed at the "left".
; @param {string} winSizeWidth       The width of the active window in relation to
;                                    the active monitor's width. Expecting "full" or "half"
;                                    size, otherwise will resize window to a "third".

Snap(monitorName, winPlaceVertical, winPlaceHorizontal, winSizeWidth) {
    SysGet, monitorWorkArea, MonitorWorkArea, %monitorName%

    if (winSizeWidth == "full") {
        width := (monitorWorkAreaRight - monitorWorkAreaLeft)
    } else if (winSizeWidth == "half") {
        width := (monitorWorkAreaRight - monitorWorkAreaLeft)/2
    } else {
        width := (monitorWorkAreaRight - monitorWorkAreaLeft)/3
    }

    if (winPlaceVertical == "top") {
        posY  := monitorWorkAreaTop
        height := (monitorWorkAreaBottom - monitorWorkAreaTop)/2
    } else if (winPlaceVertical == "bottom") {
        posY  := monitorWorkAreaTop + (monitorWorkAreaBottom - monitorWorkAreaTop)/2
        height := (monitorWorkAreaBottom - monitorWorkAreaTop)/2
    } else {
        posY  := monitorWorkAreaTop
        height := (monitorWorkAreaBottom - monitorWorkAreaTop)
    }

    if (winPlaceHorizontal == "right") {
        posX := monitorWorkAreaRight - width
    } else if (winPlaceHorizontal == "middle") {
        posX := monitorWorkAreaLeft + (monitorWorkAreaRight - monitorWorkAreaLeft - width)/2
    } else {
        posX := monitorWorkAreaLeft
    }

    ; Per-client adjustments
    WinGetTitle, winTitle, A
    no_adjustment_clients := ["Excel", "Word", "SDL Trados", "Sublime Text", "OneNote"]
    if ContainsAnyOf(winTitle, no_adjustment_clients) {
        ; Do nothing because no adjustments required
    } else {
        posX := Round(posX - 10)
        posY := Round(posY)
        width := Round(width + 20)
        height := Round(height + 10)
    }

    MsgBox % winTitle
    ; WinMove, A,, posX, posY, width, height
    Return
}

ActivateAndMove(title, posX, posY, width, height) {
    if WinExist(%title%) {
        WinActivate
        WinMove, A,, posX, posY, width, height
    }
    Return
}

RunActivateMove(title, path, posX, posY, width, height) {
    if WinExist(%title%) {
        WinActivate
        WinMove, A,, posX, posY, width, height
    }
    if !WinExist(%title%) {
        Run %path%
        WinWaitActive %title%,,10
        WinMove, %title%,, posX, posY, width, height
    }
    Return
}

; Monitor Assignments
switch A_ComputerName {
    case "SEL":
        global top_center := 4
        global main_left := 3
        global main_center := 1
        global main_right := 2
    case "X1":
        ; global top_center := 2
        global main_left := 2
        global main_center := 1
        global main_right := 3
}

; Full-monitor snaps (Hyper+Numpad) 
^!+#8::Snap(top_center, "normal", "left", "full")
^!+#5::Snap(main_center, "normal", "left", "full")
^!+#4::Snap(main_left, "normal", "left", "full")
^!+#6::Snap(main_right, "normal", "left", "full")

; Half-monitor snaps (Meh+Numpad)
^!+4::Snap(main_left, "normal", "left", "half")
^!+1::Snap(main_left, "normal", "right", "half")
^!+5::Snap(main_center, "normal", "left", "half")
^!+2::Snap(main_center, "normal", "right", "half")
^!+6::Snap(main_right, "normal", "left", "half")
^!+3::Snap(main_right, "normal", "right", "half")
^!+7::Snap(top_center, "normal", "left", "half")
^!+9::Snap(top_center, "normal", "right", "half")

;┌─────────────────────────────────────────────────────────────────────────────
;│ AUTOMATIC WINDOW CONFIGS
;└─────────────────────────────────────────────────────────────────────────────
^!#0::StandardComputerLayout()
^!#1::StenoPracticeLayout()
^!#2::TranslationLayout(main_left, main_center, main_right, top_center)
^!#4::StenoDictionaryBuildingLayout()
^!#5::StenoYouTubeLayout()
^!#6::KankenLayout()
^!#7::LeetCodeLayout()
; ^!+#Escape::ViscellLayout(main_left, main_center, main_right, top_center)

StandardComputerLayout() {
    #Include Sublime Text Startup.ahk
    Run "C:\Users\jak\Dropbox\Journals\Life HUD.xlsx"
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    Run "C:\Users\jak\Dropbox\Journals\2021 Life Journal.docx"

    Sleep 7500

    WinActivate \(SEL\) - Sublime Text
    Snap(main_center, "normal", "left", "half")
    WinActivate \(Sparrowhawk\) - Sublime Text
    Snap(main_center, "normal", "right", "half")
    WinActivate \(Scratch\) - Sublime Text
    Snap(main_right, "normal", "left", "half")

    WinActivate Life HUD.xlsx
    Snap(top_center, "normal", "left", "half")
    WinActivate 2021 Life Journal.docx
    Snap(top_center, "normal", "right", "half")
    WinActivate Google Chrome
    Snap(main_left, "normal", "right", "half")
    ; Send #d
    Return
}

ViscellLayout(main_left, main_center, main_right, top_center) {
    Send #m ; Minimize all open windows

    WinActivate, ahk_exe idea64.exe
    Snap(main_right, "normal", "right", "full")

    WinActivate, ahk_exe WindowsTerminal.exe
    Snap(main_left, "normal", "right", "half")

    WinActivate Chrome
    Snap(main_left, "normal", "left", "half")

    Return
}

TranslationLayout(main_left, main_center, main_right, top_center) {
    WinActivate \(Sparrowhawk\) - Sublime Text
    Snap(main_left, "normal", "right", "half")

    WinActivate ^((?!Keyboard Layout Editor).)*Google Chrome.*$
    Snap(main_center, "normal", "left", "half")
    Sleep 50
    Send ^4

    WinActivate SDL Trados Studio
    Snap(main_center, "normal", "right", "half")

    WinActivate ^((?!(FIGS|steno)).)*Adobe Acrobat Reader.*$
    Snap(main_right, "normal", "left", "half")

    ; WinActivate ^.*FIGS.*Adobe Acrobat Reader.*$
    ; Snap(main_right, "normal", "right", "half")

    ; WinActivate Life HUD
    ; Snap(top_center, "normal", "left", "full")

    Run HideClock.ahk
    Sleep 1500
    Run HideCounts.ahk

    Return
}

StenoPracticeLayout() {
    Run https://www.youtube.com/playlist?list=PLyc1h6zbeN84XQIAxtAVYGKba72o_Y-YQ
    Sleep 100
    Run C:\Users\jak\ALL\DV\Sparrowhawk\Utilities\steno-jig\form.html

    WinActivate Chrome
    Snap(main_left, "normal", "right", "half")

    Run "C:\Users\jak\Dropbox\Sparrowhawk\Steno Practice Manager.xlsx"
    Sleep 5000
    WinActivate Steno Practice Manager.xlsx
    Snap(main_left, "normal", "left", "half")

    WinActivate \(Sparrowhawk\) - Sublime Text
    Snap(main_right, "normal", "right", "half")
    Sleep 500
    Send !4

    Run "C:\Program Files\Anki\anki.exe"
    Return
}

StenoDictionaryBuildingLayout() {
    ; RunActivateMove("^((?!Keyboard Layout Editor).)*Google Chrome.*$"
    ;                 , "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    ;                 , -4949, -2791, 2494, 2777)
    RunActivateMove("Notepad++", "C:\Program Files (x86)\Notepad++\notepad++.exe", -11, -2777, 2400, 2777)
    RunActivateMove("\(Sparrowhawk\) - Sublime Text"
                    , "C:\Users\jak\ALL-P70\DV\Sparrowhawk\Sparrowhawk.sublime-workspace"
                    , 2458, -2777, 2494, 2777)
    #Include Steno Layouts.ahk
    Sleep 500
    RunActivateMove("Keyboard Layout Editor - Google Chrome"
                    , "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
                    , 4931, -2791, 2723, 2777)
    ; RunActivateMove("steno-alphabet-for-web-full-size.pdf - Adobe Reader"
    ;                 , "C:\Users\jak\ALL-P70\DV\Sparrowhawk\steno-alphabet-for-web-full-size.pdf"
    ;                 , 7623, -2791, 2267, 2777)
    RunActivateMove("Jak Corpus.xlsx", "C:\Users\jak\ALL-P70\DV\Sparrowhawk\Jak Corpus.xlsx"
                    , -2480, -2798, 2494, 2777)
    Sleep 500
    Send !6
    Sleep 500
    Return
}

StenoYouTubeLayout() {
    RunActivateMove("\(YouTube\) - Sublime Text"
                    , "C:\Users\jak\ALL-P70\DV\Sparrowhawk\YouTube Channel\YouTube.sublime-workspace"
                    , 640, 360, 1785, 1568)
    Send !1
    Sleep 100
    WinActivate ^Plover$ ahk_class Qt5QWindowIcon
    Send !t{Down 2}{Enter}
    WinWait Plover: Paper Tape
    ActivateAndMove("Plover: Paper Tape", 2380, 360, 786, 1110)
    RunActivateMove("\(Scratch\) - Sublime Text", "C:\Users\jak\Dropbox\Scratch.sublime-workspace"
                    , 7381, -1276, 2494, 1295)
    Send !5
    RunActivateMove("ビデオ", "C:\Users\jak\Videos", 7895, -2554, 1979, 1292)
    RunActivateMove("Express Scribe Trans", "C:\Program Files (x86)\NCH Software\Scribe\scribe.exe"
                    , 9333, -2766, 542, 232)
    WinActivate Express Scribe Free Version
    Send {Enter}
    RunActivateMove("Steno Practice Manager.xlsx - Excel"
                    , "C:\Users\jak\ALL-P70\DV\Sparrowhawk\Steno Practice Manager.xlsx"
                    , -8, -2777, 2275, 2777)
    Run C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe, C:\Program Files (x86)\obs-studio\bin\64bit
    WinWait OBS
    ActivateAndMove(OBS, 5672, -2552, 2250, 1290)
    Return
}

KankenLayout() {
    Run "C:\Program Files\Anki\anki.exe"
    Run "https://kanji.jitenon.jp/"

    Sleep 3000

    WinActivate Anki
    Snap(main_center, "normal", "left", "half")
    WinActivate Google Chrome
    Snap(main_center, "normal", "right", "half")
    Return
}

LeetCodeLayout() {
    Run "https://leetcode.com/jxcrw/"
    Run "https://leetcode.com/problemset/all/"
    Run "https://www.techinterviewhandbook.org/best-practice-questions"
    Run "https://gist.github.com/tykurtz/3548a31f673588c05c89f9ca42067bc4"

    Sleep 4000

    WinActivate Google Chrome
    Snap(main_center, "normal", "left", "half")
    WinActivate, ahk_exe idea64.exe
    Snap(main_center, "normal", "right", "half")
    WinActivate \(DV\) - Sublime Text
    Snap(main_right, "normal", "left", "half")
    WinActivate Anki
    Snap(main_right, "normal", "right", "half")
    Return
}

::\xmain::
    WinActivate \(Sparrowhawk\) - Sublime Text
    Send !5
    Return

::\xcommands::
    WinActivate \(Sparrowhawk\) - Sublime Text
    Send !6
    Return

::\xcommitmsg::
    WinActivate \(Scratch\) - Sublime Text
    Send !4
    Return

::\todo::
    Sleep 100
    Send #d
    Sleep 100
    WinActivate Chrome ; Jump to Todoist
    Snap(main_center, "normal", "left", "half")
    Sleep 50
    Send ^2
    WinActivate Life Journal
    Snap(main_center, "normal", "right", "half")
    WinActivate Life HUD
    Snap(top_center, "normal", "left", "full")
    Return

::\xcube::
    Sleep 100
    Run https://www.cubeskills.com/uploads/pdf/tutorials/pll-algorithms.pdf
    Sleep 100
    Run https://www.cubeskills.com/uploads/pdf/tutorials/oll-algorithms.pdf
    Return

;┌─────────────────────────────────────────────────────────────────────────────
;│ ALWAYS ON TOP
;└─────────────────────────────────────────────────────────────────────────────
^!#a::AlwaysOnTop()

AlwaysOnTop() {
    WinGet, currentWindow, ID, A
    WinGet, ExStyle, ExStyle, ahk_id %currentWindow%
    if (ExStyle & 0x8) { ; 0x8 is WS_EX_TOPMOST.
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
; │ Mouse Halfing/Quartering
; └─────────────────────────────────────────────────────────────────────────────
MWAGetMonitor(Mx := "", My := "") {
    if (!Mx or !My) {
        ; if Mx or My is empty, revert to the mouse cursor placement
        Coordmode, Mouse, Screen    ; use Screen, so we can compare the coords with the sysget information`
        MouseGetPos, Mx, My
    }

    SysGet, MonitorCount, 80    ; monitorcount, so we know how many monitors there are, and the number of loops we need to do
    Loop, %MonitorCount% {
        SysGet, mon%A_Index%, Monitor, %A_Index%    ; "Monitor" will get the total desktop space of the monitor, including taskbars

        if ( Mx >= mon%A_Index%left ) && ( Mx < mon%A_Index%right ) && ( My >= mon%A_Index%top ) && ( My < mon%A_Index%bottom ) {
            ActiveMon := A_Index
            break
        }
    }
    return ActiveMon
}

GetMouseMonitorData(monitor := "") {
    MouseGetPos, Mx, My
    num := MWAGetMonitor(Mx, My)

    SysGet, m, Monitor, %num%
    SysGet, wa, MonitorWorkArea, %num%

    mid_h := waLeft + (waRight - waLeft) / 2
    mid_v := waTop + (waBottom - waTop) / 2

    half_h := Mx < mid_h ? "left" : "right"
    half_v := My > mid_v ? "bottom" : "top"

    ; MsgBox, Mx:`t%Mx%`nMy:`t%My%`n
    ;        ,Monitor:`t#%num%`n
    ;        ,Left:`t%mLeft% (%waLeft% work)`n
    ;        ,Right:`t%mRight% (%waRight% work)`n
    ;        ,Top:`t%mTop% (%waTop% work)`n
    ;        ,Bottom:`t%mBottom% (%waBottom% work)`n
    ;        ,mid_h:`t%mid_h%`n
    ;        ,mid_v:`t%mid_v%`n
    ;        ,half_h:`t%half_h%`n
    ;        ,half_v:`t%half_v%`n

    return [num, half_h, half_v]
}

^!+#RButton::
    retvals := GetMouseMonitorData()
    num := retvals[1]
    half_h := retvals[2]
    half_v := retvals[3]
    Snap(num, half_v, half_h, "half")
    Return

^!+#LButton::
    retvals := GetMouseMonitorData()
    num := retvals[1]
    half_h := retvals[2]
    half_v := retvals[3]
    Snap(num, "normal", half_h, "half")
    Return

^!+#MButton::
    retvals := GetMouseMonitorData()
    num := retvals[1]
    half_h := retvals[2]
    half_v := retvals[3]
    Snap(num, "normal", "left", "full")
    Return

^!+#x::
    if WinExist("ahk_exe WindowsTerminal.exe") {
        ; MsgBox, exist
        Send ^!+#-
    } else {
        Run wt
        WinWait ahk_exe WindowsTerminal.exe
        WinActivate
        Snap(main_center, "bottom", "left", "half")
        Send {F10}
    }
    Return
