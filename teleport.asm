.ORIG x3000

TRAP	0x32 ; get pos r0-2


; case x negative (then abs the value)
ADD	R0,	R0,	#0
BRzp	END1

NOT	R0,	R0 ; comp of 2
ADD	R0,	R0,	#1 ; inc by 1

END1

; set z to -z
NOT	R2,	R2
ADD	R2,	R2,	#1

; set y to 3y
ADD	R3,	R1,	#0
ADD	R1,	R1,	R3
ADD	R1,	R1,	R3


; switch new x and z values
ADD	R4,	R0,	#0 ; prep x
ADD	R5,	R2,	#0 ; prep z

ADD	R0,	R5,	#0 ; set x
ADD	R2,	R4,	#0 ; set z



TRAP	0x33 ; teleport to coord r0-2

HALT
.END
