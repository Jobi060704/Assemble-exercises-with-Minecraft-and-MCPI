.ORIG x3000

;get pos for r0-2 of x,y,z
TRAP    0x32

; save cord to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z

; calc for easy pos for lamp cords
;; set r3 to 2
 ADD	R3,	R3,	#2
;; set r3 to -r3
 NOT	R3,	R3
 ADD	R3,	R3,	#1
;; add -2 to cords
 ADD	R0,	R0,	R3
 ADD	R2,	R2,	R3
;; set y to -1
 ADD    R1, R1, #-1
;; store tuned cords to labels
 ST R0, ez_pos_x
 ST R1, ez_pos_y
 ST R2, ez_pos_z
;


LD	R7,	MAX_H ; r7 as a loop dependant var 
LOOP BRz BUILD_DONE

    ; preload stone block id
    LD R3, bl_stone

    ; load r6 as max block height
    LD R6, MAX_H

    ; check if block height is 4 to put glowstone
    ADD R6, R7, #-1
    BRnp NO_GLOW
        
        ; set block id to glowstone
        LD R3, bl_glows

    ADD	R7,	R7,	#0 
    NO_GLOW

    ; increment y cord by 1
    ADD R1, R1, #1

    ; load fine cords
    LD	R0,	ez_pos_x
    LD	R2,	ez_pos_z

    ; set block1 (x-2 & z-2)
    ;; no tuning needed
     TRAP	0x35
    ;

    ; set block2 (x-2 & z+2)
    ;; tune for z+2
     ADD R2, R2, #4
    ;; set trap
     TRAP	0x35
    ;; revert z to ez pos
     LD	R2,	ez_pos_z
    ;

    ; set block3 (x+2 & z-2)
    ;; tune for x+2
     ADD R0, R0, #4
    ;; set trap
     TRAP	0x35
    ;; revert x to ez pos
     LD	R0,	ez_pos_x
    ;

    ; set block3 (x+2 & z+2)
    ;; tune for x+2 and z+2
     ADD R0, R0, #4
     ADD R2, R2, #4
    ;; set trap
     TRAP	0x35
    ;; revert x and z to ez pos
     LD	R0,	ez_pos_x
     LD	R2,	ez_pos_z
    ;


    ADD	R7,	R7,	#-1 
    BR LOOP
BUILD_DONE 

HALT

reg_z   .FILL   x0

HOLDER  .FILL	x0

pos_x   .FILL	x0
pos_y   .FILL	x0
pos_z   .FILL	x0

ez_pos_x   .FILL	x0
ez_pos_y   .FILL	x0
ez_pos_z   .FILL	x0

bl_stone    .FILL	#1
bl_glows    .FILL	x59

MAX_H   .FILL	#4 ; changeable variable to set how high the lamp should be

.END
