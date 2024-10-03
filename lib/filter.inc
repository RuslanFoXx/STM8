;------------------------------------------------------
;	Low Filter
;	Header Version 1.xx (STM8S003F3P)
;	For STVD MainFrame Version 3.6.5.2
;	(c) Kyiv, Ruslan FoXx
;	01 October 2024
;------------------------------------------------------
Low_Scale.w	equ 0		;	reserve ROM addresses
Low_Buffer.w	equ 2		;	index variables
Low_Result.w	equ 4

Low_level equ 8			;	internal variables
Low_integrator.w equ	9
Low_integrator1.w equ	10
Low_integrator2.w equ	11
Low_integrator3.w equ	12

	#define INTEGRATOR_FRAME_SIZE	64
	#define LOW_BUFFER_SIZE		128
	#define SHIFT_FRAME_BYTES	{INTEGRATOR_FRAME_SIZE-2}

;	#include "filter.asm"	;	insert of ROM-code
;------------------------------------------------------
;		* * *		End of File
;------------------------------------------------------
