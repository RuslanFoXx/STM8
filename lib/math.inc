;------------------------------------------------
;	Multiplying string variables of any length
;	Header Version 1.xx (STM8S003F3P)
;	For ST Visual Develop MainFrame Version 3.6.5.2
;	(c) Kyiv, Ruslan FoXx
;	01 October 2024
;------------------------------------------------
Muls_Ai.w	equ 0		;	reserve ROM addresses
Muls_Bi.w	equ 2		;	index variables
Muls_Ci.w	equ 4
Muls_carry.w	equ 8		;	internal variables
Muls_level.w	equ 10

	#define A_SIZE_BYTES  4
	#define B_SIZE_BYTES  4
	#define C_SIZE_BYTES  {A_SIZE_BYTES+B_SIZE_BYTES+1}
	#define SHIFT_RESTORE {A_SIZE_BYTES-1}

;	#include "math.asm"	;	insert of ROM-code
;------------------------------------------------------
;		* * *		End of File
;------------------------------------------------------
