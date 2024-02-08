.ORIG x3000

; make res-points for registers
ST	R0,	res_r0
ST	R1,	res_r1
ST	R2,	res_r2
ST	R3,	res_r3
ST	R4,	res_r4
ST	R5,	res_r5

; get pos r0-2
TRAP	0x32

; store player pos to labels
ST	R0,	pos_x
ST	R1,	pos_y
ST	R2,	pos_z



; fine adjust block 1 pos
ADD	R0,	R0,	#1
ADD	R1,	R1,	#-1

; get block 1 ID
TRAP    0x34
ST	R3,	bl1_id

; reset needed regs
LD	R0,	pos_x
LD	R1,	pos_y
LD	R2,	pos_z
LD	R3,	res_r3

; fine adjust block 2 pos
ADD	R0,	R0,	#2
ADD	R1,	R1,	#-1

; get block 2 ID
TRAP    0x34
ST	R3,	bl2_id




; reset r3 reg and load block data to r4-5
LD  R3, res_r3
LD	R4,	bl1_id
LD	R5,	bl2_id

; bitwise or (manual)
NOT R4 , R4 ; R1   NOT(R1 )
NOT R5 , R5 ; R2   NOT(R2 )
AND R3 , R4 , R5 ; R3   NOT(R1 ) AND NOT(R2 )
NOT R3 , R3 ; R3   R1 OR R2

; store final block id to label
ST	R3,	bl3_id

; allocate cords and final block id to regs
LD	R0,	pos_x
LD	R1,	pos_y
LD	R2,	pos_z

; tune coords for setblock
ADD	R0,	R0,	#3
ADD	R1,	R1,	#-1

; call for setBlock()
TRAP	0x35

HALT

res_r0 .FILL    x0
res_r1 .FILL    x0
res_r2 .FILL    x0
res_r3 .FILL    x0
res_r4 .FILL    x0
res_r5 .FILL    x0

pos_x .FILL	    x0
pos_y .FILL	    x0
pos_z .FILL	    x0

bl1_id .FILL	x0
bl2_id .FILL	x0
bl3_id .FILL	x0

.END
