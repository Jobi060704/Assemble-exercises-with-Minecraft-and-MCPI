.ORIG x3000

; get pos for r0-2 of x,y,z
TRAP    0x32

; save cord to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z

; tune start pos cord to regs
ADD	R0,	R0,	#-1
ADD	R1,	R1,	#-1
ADD	R2,	R2,	#-1
; store tuned cords to labels
ST R0, ez_pos_x
ST R1, ez_pos_y
ST R2, ez_pos_z

; load tot dist from labels
LD	R4,	tot_x
LD	R5,	tot_z



;;; well modify a loop from task 8 and use if-else from task 9 to make a nested loop with conditionals
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

        
        
        ;;; y check and fill
        ; r6 as check suite
        LD  R6, ez_pos_y

        ; get height -> store in r1
        TRAP	0x36

        ; negate r1 for calc
        NOT	R1,	R1
        ADD	R1,	R1,	#1

        ; calc the offset
        ADD	R6,	R6,	R1

        ; reset y to tuned cord
        LD  R1, ez_pos_y

        ; store and load to offset
        ST	R6,	offset_y
        LD  R6, offset_y

        BRz SKIP
            
            BRn ELSE

                
                ; load grass id to r3
                LD  R3, bl_grass
                
                ; increment y beforehand to fix place bug
                ADD R1, R1, #1

                LD R7, offset_y ; r7 as a loop dependant var 
                LOOP3 BRnz EXIT3
                    
                    ; sub from y cord
                    ADD	R1,	R1,	#-1

                    ; set new block at tuned pos
                    TRAP	0x35

                    ; decrement to continue loop
                    ADD R7 , R7 , #-1 
                    BR LOOP3
                EXIT3
                LD  R1, ez_pos_y



            BR   END_ELSE
            ELSE 

                ; load air id to r3
                LD  R3, bl_air

                LD R7, offset_y ; r7 as a loop dependant var 
                LOOP4 BRzp EXIT4
                    
                    ; add to y cord
                    ADD	R1,	R1,	#1

                    ; set new block at tuned pos
                    TRAP	0x35

                    ; increment to continue loop
                    ADD R7 , R7 , #1 
                    BR LOOP4
                EXIT4

            LD  R1, ez_pos_y
            END_ELSE

        LD  R1, ez_pos_y
        SKIP



        ; reset y to tuned cord
        LD  R1, ez_pos_y


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

reg_z       .FILL   x0

pos_x       .FILL	x0
pos_y       .FILL	x0
pos_z       .FILL	x0

ez_pos_x    .FILL	x0
ez_pos_y    .FILL	x0
ez_pos_z    .FILL	x0

bl_grass    .FILL	x2
bl_air      .FILL	x0

tot_x       .FILL	x3
tot_z       .FILL	x3

offset_y    .FILL	x0

.END

