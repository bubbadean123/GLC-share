
; Blink the red LED


; ---- Blink red
main:
	TOGGLE  3       ; toggle red LED
	PAUSE   30000   ; wait for ~450ms
	JMP     main

