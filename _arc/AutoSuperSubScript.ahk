; Automatically apply superscript and subscript formatting in Trados Studio.
; Jak Crow
; Created: 2017/05/11

;┌─────────────────────────────────────────────────────────────────────────────
;│ AHK Setup
;└─────────────────────────────────────────────────────────────────────────────
#NoEnv
SetBatchLines -1
ListLines Off
#SingleInstance force
StringCaseSense On
#NoTrayIcon

; ^!+#e::
; StartTime := A_TickCount
; SavedClip := ClipboardAll
Sleep 200
Clipboard :=
Send ^a^c
Sleep 200
target_text := Clipboard
; target_text := "The third p+ region 41 and the n- drift region 2 are formed at the same depth, thereby further reducing the breakdown voltage near the drain-side end of the first p+ region 4. The impurity concentration of the region is approximately 3×1019cm-3, or 3×1019/cm3. The p-type region and the n-type region."

; Tag the strings to format
tagged_text := target_text
tagged_text := RegExReplace(tagged_text, "×10(\d+)", "×10<tt>$1<tt>")
; tagged_text := RegExReplace(tagged_text, "10(\d+)/", "10<tt>$1<tt>/")
tagged_text := RegExReplace(tagged_text, "cm(-?\d+)", "cm<tt>$1<tt>")
tagged_text := StrReplace(tagged_text, "p++", "p<tt>++<tt>")
tagged_text := StrReplace(tagged_text, "p+", "p<tt>+<tt>")
tagged_text := RegExReplace(tagged_text, " p-(?!type|n)", " p<tt>-<tt>")
tagged_text := StrReplace(tagged_text, "n+", "n<tt>+<tt>")
tagged_text := RegExReplace(tagged_text, " n-(?!type)", " n<tt>-<tt>")
tagged_text := StrReplace(tagged_text, "wCELL", "w<tt>CELL<tt>")
tagged_text := StrReplace(tagged_text, "wJFET", "w<tt>JFET<tt>")
tagged_text := StrReplace(tagged_text, "wcb", "w<tt>cb<tt>")
tagged_text := StrReplace(tagged_text, "wtb", "w<tt>tb<tt>")
tagged_text := StrReplace(tagged_text, "Vm", "V<tt>m<tt>")
tagged_text := StrReplace(tagged_text, "Vr", "V<tt>r<tt>")
tagged_text := StrReplace(tagged_text, "Vsw", "V<tt>sw<tt>")
tagged_text := StrReplace(tagged_text, "Vns", "V<tt>ns<tt>")
; tagged_text := StrReplace(tagged_text, "Vg", "V<tt>g<tt>")
tagged_text := StrReplace(tagged_text, "Vnc", "V<tt>nc<tt>")
tagged_text := StrReplace(tagged_text, "Vtd", "V<tt>td<tt>")
; tagged_text := StrReplace(tagged_text, "Vth", "V<tt>th<tt>")
tagged_text := StrReplace(tagged_text, "Cc", "C<tt>c<tt>")
tagged_text := StrReplace(tagged_text, "Ce", "C<tt>e<tt>")
tagged_text := StrReplace(tagged_text, "Cf", "C<tt>f<tt>")
; tagged_text := StrReplace(tagged_text, "Co", "C<tt>o<tt>")
tagged_text := StrReplace(tagged_text, "Cs", "C<tt>s<tt>")
tagged_text := StrReplace(tagged_text, "Cp", "C<tt>p<tt>")
tagged_text := StrReplace(tagged_text, "IL", "I<tt>L<tt>")
; tagged_text := StrReplace(tagged_text, "Is", "I<tt>s<tt>")
tagged_text := StrReplace(tagged_text, "Ic", "I<tt>c<tt>")
tagged_text := StrReplace(tagged_text, "Isat", "I<tt>sat<tt>")
tagged_text := StrReplace(tagged_text, "Ion", "I<tt>on<tt>")
tagged_text := StrReplace(tagged_text, "Kp", "K<tt>p<tt>")
tagged_text := StrReplace(tagged_text, "Rs", "R<tt>s<tt>")
tagged_text := StrReplace(tagged_text, "Rds", "R<tt>ds<tt>")
tagged_text := StrReplace(tagged_text, "Rbi", "R<tt>bi<tt>")
tagged_text := StrReplace(tagged_text, "Rci", "R<tt>ci<tt>")
tagged_text := StrReplace(tagged_text, "Sds", "S<tt>ds<tt>")
tagged_text := StrReplace(tagged_text, "Q1", "Q<tt>1<tt>")
tagged_text := StrReplace(tagged_text, "a1", "a<tt>1<tt>")
tagged_text := StrReplace(tagged_text, "b1", "b<tt>1<tt>")
tagged_text := StrReplace(tagged_text, "c1", "c<tt>1<tt>")
tagged_text := StrReplace(tagged_text, "r1", "r<tt>1<tt>")
tagged_text := StrReplace(tagged_text, "a2", "a<tt>2<tt>")
tagged_text := StrReplace(tagged_text, "b2", "b<tt>2<tt>")
tagged_text := StrReplace(tagged_text, "c2", "c<tt>2<tt>")
tagged_text := StrReplace(tagged_text, "r2", "r<tt>2<tt>")
tagged_text := StrReplace(tagged_text, "a3", "a<tt>3<tt>")
tagged_text := StrReplace(tagged_text, "b3", "b<tt>3<tt>")
tagged_text := StrReplace(tagged_text, "c3", "c<tt>3<tt>")
tagged_text := StrReplace(tagged_text, "r3", "r<tt>3<tt>")
tagged_text := StrReplace(tagged_text, "=", " = ")
; MsgBox % tagged_text

chunked_text := StrSplit(tagged_text, "<tt>")
superscript_words := ["+", "-", "++"]
subscript_words := ["CELL", "JFET", "tb", "cb", "m", "r", "sw", "L", "p", "s", "ds", "bi", "ci", "1", "2", "3", "c", "e", "f", "o", "s", "ns", "g", "nc", "td", "th", "sat", "on"]

for key, chunk in chunked_text {
    ; MsgBox % chunk
    if HasValue2(superscript_words, chunk) {
        Superscript(chunk)
        ; MsgBox super
    } else if HasValue2(subscript_words, chunk) {
        Subscript(chunk)
        ; MsgBox sub
    } else if IsNumber(chunk) {
        Superscript(chunk)
        ; MsgBox number
    } else {
        Clipboard := chunk
        Sleep 100
        Send ^v
        ; MsgBox nothing
    }
}

; ; Cleanup
; ; Clipboard := SavedClip
; ; ElapsedTime := A_TickCount - StartTime
; ; MsgBox,  %ElapsedTime% milliseconds have elapsed.
Sleep 70
Send ^{Space}
Send t{BackSpace}
ExitApp

;┌─────────────────────────────────────────────────────────────────────────────
;│ Functions 
;└─────────────────────────────────────────────────────────────────────────────
Superscript(string) {
    Clipboard := string
    Send ^+{=}
    Sleep 125
    Send ^v
    Sleep 125
    Send ^{Space}
    Sleep 125
}

Subscript(string) {
    Clipboard := string
    Send ^{=}
    Sleep 125
    Send ^v
    Sleep 125
    Send ^{Space}
    Sleep 125
}

HasValue2(haystack, needle) {
    if (!isObject(haystack))
        Return false
    if (haystack.Length()==0)
        Return false
    for k, v in haystack
        if (v==needle)
            Return true
    Return false
}

IsNumber(var) {
    if var is number
        Return true
    else
        Return false
}
