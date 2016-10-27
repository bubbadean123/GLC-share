; Enable interrupts for the buttons
; Pin:  7 6 5 4 3 2 1 0
; Mask: 0 0 0 0 0 1 1 0 = 6dec
	ENABLE  6

	MOV b0, 0x0


main:
	JMP     main


; ---- called via interrupt when the red button is pressed
isrr:
	cmp b0, 0x0
	jz red
	cmp b0, 0x1
	jz yellow
	cmp b0, 0x2
	jz green

red:
	high 3
	low 4
	low 5
	mov b0, 0x1
	reti
yellow:
	low 3
	high 4
	low 5
	mov b0, 0x2
	reti

green:
	low 3
	low 4
	high 5
	mov b0, 0x0
	reti
isrb:
	MOV b0, 0x0
	call isrr
	RETI

; ---- interrupt table
	ORG     0x100
	DW      0	; pin 0 (not wired)
	DA      isrb	; black button
	DA      isrr    ; red button

END

