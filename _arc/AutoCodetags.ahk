; Automatically code tag codey things in Trados Studio.
; Jak Crow
; Created: 2016/09/30
;┌─────────────────────────────────────────────────────────────────────────────
;│ REVISION HISTORY
;└─────────────────────────────────────────────────────────────────────────────
; 2016/10/16
; - Fixed a bug where repetition of a code word within another code word would cause
;   the script to apply code tags incorrectly.

; 2016/10/08
; - Added support for manually specifying code chunks. The syntax is: ,,code_chunk,,.

; 2016/10/06
; - Added support for just inserting and code tagging the source segment.
; - The script now uses the clipboard rather than the search box to code tag words.
;   This approach is faster, more reliable, and handles edge cases such as duplicate
;   code words in the target text more robustly.

; ;┌─────────────────────────────────────────────────────────────────────────────
; ;│ AHK Setup
; ;└─────────────────────────────────────────────────────────────────────────────
; #NoEnv
; SetBatchLines -1
; ListLines Off
; #SingleInstance force
; StringCaseSense On

;┌─────────────────────────────────────────────────────────────────────────────
;│ Auto-Code Tags
;└─────────────────────────────────────────────────────────────────────────────
; ^!+k::
; StartTime := A_TickCount
; SavedClip := ClipboardAll
Sleep 100
Clipboard :=
Send ^a^c
Sleep 100
target_text := Clipboard
; target_text := "The nn::MyFunc() and the nn::MyFuncYourFunc() functions."

code_word_patterns := ["::" ; namespace::library::FunctionName()
                , "__" ; some__variable
                , "--[A-Za-z0-9]" ; --options
                , "[A-Za-z0-9]+_[A-Za-z0-9]+" ; snake_case_words
                , "[a-z]([A-Z0-9]*[a-z][a-z0-9]*[A-Z]|[a-z0-9]*[A-Z][A-Z0-9]*[a-z])[A-Za-z0-9]*" ; CamelCase and camelCase words
                , "[A-Za-z0-9]+\.[a-z]+" ; filename.extension
                , "\(\)" ; somefunction()
                , "[A-Z]{2,}[a-z0-9]+" ; ABCcodeword
                , "[a-z]+[0-9]" ; codeword123
                , "[A-Za-z0-9]+\\" ; Path\\SomeDirectory\\SomeFile
                , "-[A-Za-z0-9]+-[A-Za-z0-9]+" ; 
                , "<[A-Za-z0-9]+>"] ; <codewords>

never_code_words = 
(
kthxwtfbbq,kthxwtfbbq2
)

always_code_words = 
(
bool,true,false
)

; ; Just inserting and code tagging source text.
; if (target_text == "") {
;     Send ^{Insert}^a^c
;     ClipWait
;     ; MsgBox % Clipboard
;     if RegExMatch(Clipboard, "(^-|^\*)") { ; TU is just function name starting with a dash
;         Send ^{Insert}
;         Send {Right}{Right}
;         Send ^+{Down}
;         Send ^+k
;         Send ^{Enter}
;         Return
;     } else if RegExMatch(Clipboard, "^・") {
;         Clipboard := RegExReplace(Clipboard, "^・", "•")
;         Sleep 1000
;         Send ^v
;         Send {Right}
;         Send ^+{Down}
;         Send ^+k
;         Send ^{Enter}
;         Return
;     } else { ; Source text needs to be copied in and code tagged
;         Send ^{Insert}^a
;         Send ^+k
;         Send ^{Enter}
;         Return
;     }
; }

; Parse target text and create array of code words
code_words := []
Loop, Parse, target_text, %A_Space%, .
{
    word := A_LoopField
    ; MsgBox The word is "%word%"
    if RegExMatch(word, "^,,") ; Manually tagged words
    {
        FoundPos := RegExMatch(target_text, ",,(.*?),,", match)
        code_words.Insert(match1)
        target_text := RegExReplace(target_text, ",,(.*?),,", "$1", , 1, FoundPos)
        continue
    }
    if word not contains %never_code_words%
    {
        if word in %always_code_words%
        {
            code_words.Insert(word)
            continue
        }
        for key, code_word_pattern in code_word_patterns {
            if RegExMatch(word, code_word_pattern)
            {
                ; MsgBox % "The pattern is " . code_word_pattern . ", which evaluates to " . RegExMatch(word, code_pattern)
                code_words.Insert(word)
                break
            }
        }
    }
}
; MsgBox % "There are " . code_words.MaxIndex() . " code words:`n`n" . Join("`n", code_words*)

; Sanitize code_words
for key, word in code_words {
    word := RegExReplace(word, "^\(", "") ; Remove preceding (
    word := RegExReplace(word, "(?<!\()\)$", "") ; Remove trailing ) if not preceded by (
    word := RegExReplace(word, "(\.|,)$", "") ; Remove trailing . or ,
    code_words[key] := word
}

; Code tag the code words
tagged_text := target_text
for key, code_word in code_words {
    ; MsgBox % code_word
    tagged_text := StrReplace(tagged_text, code_word, "<tt>" . code_word . "<tt>")
    tagged_text := RegExReplace(tagged_text, "(?<=( |,|\.|\())" . code_word . "(?=( |,|\.|\)))", "<tt>" . code_word . "<tt>")
}
; MsgBox % tagged_text

chunked_text := StrSplit(tagged_text, "<tt>")

for key, chunk in chunked_text {
    ; MsgBox % chunk
    if (HasValue(code_words, chunk)) {
        CodeTag(chunk)
    } else {
        Clipboard := chunk
        Sleep 100
        Send ^v
    }
}

; Cleanup
; Clipboard := SavedClip
; ElapsedTime := A_TickCount - StartTime
; MsgBox,  %ElapsedTime% milliseconds have elapsed.
ExitApp

;┌─────────────────────────────────────────────────────────────────────────────
;│ Functions 
;└─────────────────────────────────────────────────────────────────────────────
CodeTag(code_word) {
    Clipboard := code_word
    Send ^+k
    Sleep 100
    Send ^v
    Sleep 100
    Send {Right}
    Sleep 100
}

HasValue(haystack, needle) {
    if(!isObject(haystack))
        return false
    if(haystack.Length()==0)
        return false
    for k,v in haystack
        if(v==needle)
            return true
    return false
}

Join(sep, params*) {
    for index, param in params
        str .= sep . param
    return SubStr(str, StrLen(sep)+1)
}

