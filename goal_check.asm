.ORIG x3000

ADD	R7,	R7,	#0 ; r7 as a loop dependant var 
LOOP BRnp GOAL_REACHED
    
    ;get pos for r0-2 of x,y,z
    TRAP    0x32

    ; r5-6 as goal vars
    LD	R5,	GOAL_X
    LD	R6,	GOAL_Z

    ; negate x and z vars for calc
    NOT	R0,	R0
    ADD	R0,	R0,	#1
    NOT	R2,	R2
    ADD	R2,	R2,	#1

    ; check if x cord is right
    ADD R5, R5, R0
    BRnp fail_x
        ; check if z cord is right
        ADD R6, R6, R2
        BRnp fail_y

            ; success
            ADD	R7,	R7,	#1

        fail_y
    ADD	R7,	R7,	#0 
    fail_x

    ADD	R7,	R7,	#0 
    BR LOOP
GOAL_REACHED 

; message out
LEA	R0,	MSG
TRAP    0x31

HALT

reg_z .FILL     x0
MSG   .STRINGZ	"Goal reached! Halted..."

; Note: Please do not change the names of the constants below
GOAL_X .FILL #4
GOAL_Z .FILL #-5

.END
