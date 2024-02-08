.ORIG x3000

TRAP	0x32 ; get pos r0-2
ADD	R1,	R1,	#-1 ; sub 1 from r1 that y cord - 1 (ground player standing on)
TRAP    0x34 ; get block id from r0-2 store in r3


; stone case
ADD	R4,	R3,	#-1 ; check if blockID - 1 = 0 (means block is stone)
BRnp	END1

LEA R0, MSG1 ; load message in r0
TRAP    0x31 ; post message from r0
HALT

END1


; grass case
ADD	R4,	R4,	#-1 ; after r4 decrement, ; check again if blockID - 1 = 0 (means block is grass)
BRnp	END2

LEA R0, MSG2 ; load message in r0
TRAP    0x31 ; post message from r0
HALT

END2


; neither stone or grass case
LEA R0, MSGe ; load message in r0
TRAP    0x31 ; post message from r0
HALT


MSG1 .STRINGZ	"The block beneath the player tile is stone"
MSG2 .STRINGZ	"The block beneath the player tile is grass"
MSGe .STRINGZ	"The block beneath the player tile is neither stone nor grass"

.END
