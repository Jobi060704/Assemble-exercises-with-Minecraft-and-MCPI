.ORIG x3000

TRAP	0x32 ; get tile pos r0,1,2 to x,y,z

LD R3, BLID ; fill r3 with block num id for gold

ADD	R2,	R2,	#4  ; offset z cord by 4

TRAP    0x36 ; get height of r0,2 that x,z and save to r1

ADD	R1,	R1,	#1 ; add 1 to r1 that y cord + 1

TRAP    0x35 ; set block at r0,1,2 with block r3

HALT

BLID .FILL	x29

.END