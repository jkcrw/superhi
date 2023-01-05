; Chords
; Jak Crow
; 2015/11/23
; Chorded input.

#SingleInstance force

Chord(string)
{
    SendInput {Backspace}
    SendInput {Space}%string%{Space}
    Return
}

~f & p::
~p & f::Chord("of a")

~f & /::
~/ & f::Chord("of an")

~f & `;::
~`; & f::Chord("of the")

~a & p::
~p & a::Chord("and a")

~a & /::
~/ & a::Chord("and an")

~a & `;::
~`; & a::Chord("and the")

~f & j::
~j & f::Chord("such as")

~t & p::
~p & t::Chord("to a")

~t & /::
~/ & t::Chord("to an")

~t & `;::
~`; & t::Chord("to the")
