.ORIG x3000

; get pos for r0-2 of x,y,z
TRAP    0x32

; save cord to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z


; tune cord to regs
;; tune the cords for placement
 ADD	R0,	R0,	#1
 ADD	R2,	R2,	#1
;; store tuned cords to labels
 ST R0, ez_pos_x
 ST R1, ez_pos_y
 ST R2, ez_pos_z
;

; load grass id to r3
LD  R3, bl_stone


; using another label for stairway level fixes
LD  R7, STAIRS_LENGTH
; increment by 1
ADD R7, R7, #1
; store
ST  R7, level_fix
; reser reg
LD	R7,	reg_z


;;; well modify a loop from task 8 to make a triple nested loop from 2d to 3d placements
; decrement y beforehand to fix place bug
ADD R1, R1, #-1
; decrement z beforehand to fix place bug
ADD R2, R2, #-1

LD R6, STAIRS_HEIGHT ; r6 as a loop dependant var 
LOOP0 BRnz EXIT0
    
    ; add to y cord
    ADD	R1,	R1,	#1

    ; gradual z fix for stairway effect
    ADD	R2,	R2,	#1
    ST	R2,	ez_pos_z


    ; decrement level_fix to correct overplacement
    LD  R7, level_fix
    ; decrement by 1
    ADD R7, R7, #-1
    ; store
    ST  R7, level_fix
    ; reser reg
    LD	R7,	reg_z
    


    ; decrement x beforehand to fix place bug
    ADD R0, R0, #-1

    LD R4, STAIRS_WIDTH ; r4 as a loop dependant var 
    LOOP1 BRnz EXIT1
        
        ; add to x cord
        ADD	R0,	R0,	#1

        
        ; decrement z beforehand to fix place bug
        ADD R2, R2, #-1


        LD R5, level_fix ; r5 as a loop dependant var 
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


    ; reset x to tuned cord
    LD R0, ez_pos_x ;


    ; decrement to continue loop
    ADD R6 , R6 , #-1 
    BR LOOP0
EXIT0


HALT

reg_z   .FILL   x0

pos_x   .FILL	x0
pos_y   .FILL	x0
pos_z   .FILL	x0

ez_pos_x   .FILL	x0
ez_pos_y   .FILL	x0
ez_pos_z   .FILL	x0

bl_stone   .FILL	x1

level_fix .FILL	x0

; Note: Please do not change the names of the constants below
STAIRS_WIDTH .FILL #2
STAIRS_LENGTH .FILL #4
STAIRS_HEIGHT .FILL #3

.END
