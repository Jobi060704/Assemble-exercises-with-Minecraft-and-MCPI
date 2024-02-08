.ORIG x3000

; get pos r0-2
TRAP	0x32

; fine tune y cord
ADD	R1,	R1,	#-1

; store player pos to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z


LD R5, LINE_LEN ; r5 as a loop dependant var 
LOOP BRz EXIT
    
    ; add to x cord
    ADD	R0,	R0,	#1

    ; scan block at tuned pos
    TRAP	0x34

    ; set block id to +1
    ADD	R3,	R3,	#1

    ; set new block at tuned pos
    TRAP	0x35

    ; decrement to continue loop
    ADD R5 , R5 , #-1 
    BR LOOP
EXIT 

HALT

reg_z .FILL     x0

pos_x .FILL	    x0
pos_y .FILL	    x0
pos_z .FILL	    x0

LINE_LEN .FILL #5 ; Note: Please do not change the name of this constant

.END
