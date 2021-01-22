.cseg
.org 0x120
ldi R25, 0b00001111					;setting port b low order bits as output
sts 0x25, R25
ldi R26, 0b11110000					;setting port d  high order bits as output
sts 0x2B, R26

load_Character:
ldi R30, LOW(Lookup_Table<<1)		; loading the low order address location of the table into register 30
ldi R31, HIGH(Lookup_Table<<1)		; loading the high order address location of the table
ldi R20, 0x14						; load register 20 with hex 14 which is a counter

Main:
call Display
dec R20								;dec counter
cpi R20, 0x00						;compare register 20(counter) with hex 0
BRNE Main							;Branch to main if counter not equal to 0
rjmp load_character					; reset counter and load the characters again if counter is 0

Display:
lpm r15, z+							; loading the value of pointer z to register 15
sts 0x2B, r15						; send the value in register to port d and increment Z to point next value
lpm r15, z+							; loading the value of pointer z to register 15
sts 0x25, r15						; send the value in register to port d and increment Z to point next value
call delay							; call the delay function
call delay							; call the delay function
ret									; Return to main function (from where the display function is called)
delay:
	ldi r21, 0x32
delay2:
	ldi r22, 0xc8
delay1:
	ldi r23, 0xc7
delay0:
	nop
	nop
	nop
	dec r23
	cpi r23, 0x00
	brne delay0
	nop
	nop
	nop
	dec r22
	cpi r22, 0x00
	brne delay1
	dec r21
	cpi r21, 0x00
	brne delay2
ret

.org 0x100 			; Set the data segment start location as 0x100
Lookup_Table:
.db 0XF0, 0X03, 0X60, 0X00, 0XB0, 0X05, 0XF0, 0X04, 0X60, 0X06, 0XD0, 0X06, 0XD0, 0X07, 0X70, 0X00, 0XF0, 0X07, 0XF0, 0X06, 0X70, 0X07, 0XF0, 0X07, 0X90, 0X03, 0XF0, 0X03, 0X90, 0X07, 0X10, 0X07, 0X00, 0X04, 0X70, 0X00, 0XE0, 0X00, 0XF0, 0X04 

