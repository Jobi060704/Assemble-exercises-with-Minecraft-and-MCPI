.ORIG x3000

; get pos for r0-2 of x,y,z
TRAP    0x32

; save cord to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z

;calc for cord diff (x)
;; negate goal value of x
 LD  R3, G_X
 NOT	R3,	R3
 ADD	R3,	R3,	#1
 ; calc x dist (raw)
 ADD	R0,	R0, R3
 ; abs the value
 ADD    R0,	R0,	#0
 BRzp	END1
    NOT	R0,	R0
    ADD	R0,	R0,	#1
 END1
 ; store the x diff
 ST	R0,	diff_x
;

;calc for cord diff (y)
;; negate goal value of y
 LD  R4, G_Y
 NOT	R4,	R4
 ADD	R4,	R4,	#1
 ; calc y dist (raw)
 ADD	R1,	R1, R4
 ; abs the value
 ADD    R1,	R1,	#0
 BRzp	END2
    NOT	R1,	R1
    ADD	R1,	R1,	#1
 END2
 ; store the y diff
 ST	R1,	diff_y
;

;calc for cord diff (z)
;; negate goal value of z
 LD  R5, G_Z
 NOT	R5,	R5
 ADD	R5,	R5,	#1
 ; calc z dist (raw)
 ADD	R2,	R2, R5
 ; abs the value
 ADD    R2,	R2,	#0
 BRzp	END3
    NOT	R2,	R2
    ADD	R2,	R2,	#1
 END3
 ; store the z diff
 ST	R2,	diff_z
;

; reset all regs
LD  R0, reg_z
LD  R1, reg_z
LD  R2, reg_z
LD  R3, reg_z
LD  R4, reg_z
LD  R5, reg_z




; goal dist squaring
LD R5, GOAL_DIST ; r5 as a loop dependant var 
LD R6, GOAL_DIST ; r6 as a addition suite 
LD R7, reg_z ;r7 as a final result
ADD	R5,	R5,	#0
LOOP1 BRnz DED1
    
    ADD	R7,	R7,	R6

    ; decrement to continue loop
    ADD R5 , R5 , #-1 
    BR LOOP1
DED1

ST	R7,	goal_tot ; store tot dist allowed squared


; x dist squaring
LD R5, diff_x ; r5 as a loop dependant var 
LD R6, diff_x ; r6 as a addition suite 
LD R7, reg_z ;r7 as a final result
ADD	R5,	R5,	#0
LOOP2 BRnz DED2
    
    ADD	R7,	R7,	R6

    ; decrement to continue loop
    ADD R5 , R5 , #-1 
    BR LOOP2
DED2

ST	R7,	diff_x ; overwrite x dist squared


; y dist squaring
LD R5, diff_y ; r5 as a loop dependant var 
LD R6, diff_y ; r6 as a addition suite 
LD R7, reg_z ;r7 as a final result
ADD	R5,	R5,	#0
LOOP3 BRnz DED3
    
    ADD	R7,	R7,	R6

    ; decrement to continue loop
    ADD R5 , R5 , #-1 
    BR LOOP3
DED3

ST	R7,	diff_y ; overwrite y dist squared


; z dist squaring
LD R5, diff_z ; r5 as a loop dependant var 
LD R6, diff_z ; r6 as a addition suite 
LD R7, reg_z ;r7 as a final result
ADD	R5,	R5,	#0
LOOP4 BRnz DED4
    
    ADD	R7,	R7,	R6

    ; decrement to continue loop
    ADD R5 , R5 , #-1 
    BR LOOP4
DED4

ST	R7,	diff_z ; overwrite z dist squared


; reset used regs
LD  R5, reg_z
LD  R6, reg_z
LD  R7, reg_z


; adding all squareds' together
LD  R5, diff_x
LD  R6, diff_x
LD  R7, diff_x

; adding to r4
LD	R4, reg_z
ADD	R4,	R4, R5
ADD	R4,	R4, R6
ADD	R4,	R4, R7

; storing tot diff with new additions
ST	R4,	diff_tot


; check if actual dist < allowed dist
LD  R5, goal_tot
LD	R6,	diff_tot
; negate for substraction
NOT	R6,	R6
ADD	R6,	R6,	#1
; substract 2 values (if result > 0, then it is a pass)
ADD R5, R5, R6
BRnz ELSE

    LEA R0, MSGt ; load message in r0
    TRAP    0x31 ; post message from r0

BR   END_ELSE
ELSE 

    LEA R0, MSGf ; load message in r0
    TRAP    0x31 ; post message from r0

END_ELSE



HALT

reg_z   .FILL   x0

pos_x   .FILL	x0
pos_y   .FILL	x0
pos_z   .FILL	x0

diff_x  .FILL	x0
diff_y  .FILL	x0
diff_z  .FILL	x0

diff_tot    .FILL	x0
goal_tot    .FILL	x0

MSGt .STRINGZ	"The player is within distance of the goal"
MSGf .STRINGZ	"The player is outside the goal bounds"

; Note: Please do not change the names of the constants below
G_X .FILL #7
G_Y .FILL #-8
G_Z .FILL #5
GOAL_DIST .FILL #10

.END


