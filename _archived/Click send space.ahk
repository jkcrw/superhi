;Click Space
;Jak Crow
;2014/08/09
;Waits for a mouse click and then sends a space
;(This is for making drilling Kanken cards go faster - put the mouse on the floor and use your foot to advance cards - or use the mouse with your left hand
;to hold down the page)

#SingleInstance force

; CoordMode, Mouse, Screen ;sets mouse stuff to use screen coords
 
; Loop, 1000
; {
; 	KeyWait, MButton, D
;     KeyWait, MButton
; 	Send {Space}
; }

MButton::Space
