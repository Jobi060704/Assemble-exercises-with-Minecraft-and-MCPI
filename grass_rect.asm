.ORIG x3000

; get pos for r0-2 of x,y,z
TRAP    0x32

; save cord to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z


; tune goal dist cord to regs
LD  R3, X_DIST
LD  R4, Z_DIST
;; set negate r3-4
 NOT	R3,	R3
 ADD	R3,	R3,	#1
 NOT	R4,	R4
 ADD	R4,	R4,	#1
;; tune the cords
 ADD	R0,	R0,	R3
 ADD	R2,	R2,	R4
;; set y to -1
 ADD    R1, R1, #-1
;; store tuned cords to labels
 ST R0, ez_pos_x
 ST R1, ez_pos_y
 ST R2, ez_pos_z
;


; load grass id to r3 and reset r4
LD  R3, bl_grass
LD	R4, reg_z


; add total x and z lenghts to labels (for use in loops)
;; load r4-5 with dist
 LD	R4,	X_DIST
 LD	R5,	Z_DIST
;; make r4 -> 2*r4+1 (total length formula)
 ADD    R4, R4, R4
 ADD    R4, R4, x1
;; make r5 -> 2*r5+1 (total length formula)
 ADD    R5, R5, R5
 ADD    R5, R5, x1
;; store tot dist to labels
 ST	R4,	tot_x
 ST	R5,	tot_z
;; reset r4-5
 LD R4, reg_z
 LD R5, reg_z
;



;;; well modify a loop from task 5 to make a nested loop from 1d to 2d placements
; decrement x beforehand to fix place bug
ADD R0, R0, #-1

LD R4, tot_x ; r5 as a loop dependant var 
LOOP1 BRnz EXIT1
    
    ; add to x cord
    ADD	R0,	R0,	#1

    
    ; decrement z beforehand to fix place bug
    ADD R2, R2, #-1

    LD R5, tot_z ; r5 as a loop dependant var 
    LOOP2 BRnz EXIT2
        
        ; add to z cord
        ADD	R2,	R2,	#1

        ; set new block at tuned pos
        TRAP	0x35

        ; decrement to continue loop
        ADD R5 , R5 , #-1 
        BR LOOP2
    EXIT2 

    ; reset z to tuned cord
    LD R2, ez_pos_z


    ; decrement to continue loop
    ADD R4 , R4 , #-1 
    BR LOOP1
EXIT1


HALT

reg_z   .FILL   x0

pos_x   .FILL	x0
pos_y   .FILL	x0
pos_z   .FILL	x0

ez_pos_x   .FILL	x0
ez_pos_y   .FILL	x0
ez_pos_z   .FILL	x0

bl_grass   .FILL	x2

tot_x      .FILL	x0
tot_z      .FILL	x0

; Note: Please do not change the names of the constants below
X_DIST .FILL #2
Z_DIST .FILL #3

.END

