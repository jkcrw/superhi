; Modified Maltron keyboard layout for ErgoDox EZ
; Jak Crow
; Created: 2016/10/15

; A keyboard layout based on the Maltron layout. Several key positions have been
; altered to address what I felt were weaknesses in the original design.
; In particular, this layout is designed to promote outward to inward finger rolling
; for common English bigraphs and trigraphs (as opposed to inward to outward finger rolling
; as in original Malt). In addition, the highest frequency punctuation symbols are all
; contained within the main letter area.

; Key Layout
; ┌───────┬─────┬─────┬─────┬─────┬─────┬─────┐     ┌─────┬─────┬─────┬─────┬─────┬─────┬───────┐
; │   -   │ F1  │ F2  │ F3  │ F4  │ F5  │CpLck│     │     │  F6 │  F7 │  F8 │  F9 │ F10 │   `   │
; ├───────┼─────┼─────┼─────┼─────┼─────┼─────┤     ├─────┼─────┼─────┼─────┼─────┼─────┼───────┤
; │Ent/MED│  Q  │  Y  │  P  │  B  │  ;  │ F13 │     │ CALC│  -  │  U  │  M  │  L  │  Z  │\ / MED│
; ├───────┼─────┼─────┼─────╆─────╅─────┤CALEN│     │     ├─────╆─────╅─────┼─────┼─────┼───────┤
; │Tab/SYM│  A  │  I  │  N  │  S  │  F  ├─────┤     ├─────┤  D  │  H  │  T  │  R  │  O  │" / SYM│
; ├───────┼─────┼─────┼─────╄─────╃─────┤Space│     │ Esc ├─────╄─────╃─────┼─────┼─────┼───────┤
; │ LSft  │  X  │  J  │  C  │  G  │  .  │     │     │     │  ,  │  V  │  W  │  K  │  ?  │  RSft │
; └─┬─────┼─────┼─────┼─────┼─────┼─────┴─────┘     └─────┴─────┼─────┼─────┼─────┼─────┼─────┬─┘
;   │LCtrl│ Win │ Alt │  (  │  )  │                             │  ←  │  ↓  │  ↑  │  →  │PrtSc│
;   └─────┴─────┴─────┴─────┴─────┘ ┌─────┬─────┐ ┌─────┬─────┐ └─────┴─────┴─────┴─────┴─────┘
;                                   │ Esc │PgDn │ │ PgUp│ Esc │
;                             ┌─────┼─────┼─────┤ ├─────┼─────┼─────┐
;                             │     │     │ Ins │ │ Home│     │     │
;                             │  E  │Bkspc├─────┤ ├─────┤Enter│Space│
;                             │(F23)│     │ Del │ │ End │     │     │
;                             └─────┴─────┴─────┘ └─────┴─────┴─────┘

; Remap the keys
#InputLevel 1
q::Send q
+q::Send Q
w::Send y
+w::Send Y
e::Send p
+e::Send P
r::Send b
+r::Send B
t::Send `;
+t::Send `:
y::Send -
+y::Send _
u::Send u
+u::Send U
i::Send m
+i::Send M
o::Send l
+o::Send L
p::Send z
+p::Send Z
a::Send {a}
+a::Send {A}
s::Send i
+s::Send I
d::Send n
+d::Send N
f::Send s
+f::Send S
g::Send f
+g::Send F
h::Send d
+h::Send D
j::Send h
+j::Send H
k::Send t
+k::Send T
l::Send r
+l::Send R
`;::Send o
+`;::Send O
z::Send x
+z::Send X
x::Send j
+x::Send J
c::Send c
+c::Send C
v::Send g
+v::Send G
; v::Send k
; +v::Send K
b::Send .
+b::Send <
n::Send `,
+n::Send >
m::Send v
+m::Send V
,::Send w
+,::Send W
.::Send k
+.::Send K
; .::Send g
; +.::Send G
/::Send /
+/::Send ?
F23::Send e
+F23::Send E
F24::Send $
+F24::Send $


; Don't let modifiers act on alternative keyboard layout.
; In other words, keep QWERTY layout for shortcut keys.
Loop {
    If  !GetKeyState("Control") 
    and !GetKeyState("Alt") 
    and !GetKeyState("LWin") 
    and !GetKeyState("RWin") {
        Suspend, Off
    } else {
        Suspend, On
    }
    Sleep, 50
}
