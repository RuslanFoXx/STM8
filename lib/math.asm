;------------------------------------------------
;	Multiplying string variables of any length
;	Function Version 1.xx (STM8S003F3P)
;	For STVD MainFrame Version 3.6.5.2
;	(c) Kyiv, Ruslan FoXx
;	01 October 2024
;------------------------------------------------
;	ldw Muls_Ai, #value_A
;	ldw Muls_Bi, #value_B
;	ldw Muls_Ci, #value_C
;------------------------------------------------
muls.l
	ld	A, #C_SIZE_BYTES

clear@muls.w
	ldw	Y, Muls_Ci		;	clear C variable
	ldw	X, Y
	dec A
	jrne clear@muls

	ld	A, #B_SIZE_BYTES

level@muls.w
	push	A			;	PUSH level

	clrw	X
	ldw	Muls_carry, X		;	carry = 0

	ld	A, [Muls_Bi]		;	get byte k = B[level]
	cp	A, #0			;	if var==0 next level
	jreq zero@muls

		ld	Muls_level, A
		ld	A, #A_SIZE_BYTES

step@muls.w
		push	A		;	PUSH index

		clrw	X
		ld	A, (Y)
		ld	XL, A
		addw	X,	Muls_carry
		ldw	Muls_carry, X	;	carry = C[index]

		ld	A, [Muls_Ai]	;	X = A[index] * k
		ld	XL,	A
		ld	A, Muls_level
		mul	X,	A

		addw	X, Muls_carry	;	C[index]= X + carry
		ld	A, XL
		ld	(Y), A

		ld	A, XH
		ld	XL, A
		clr	A
		ld	XH, A
		ldw	Muls_carry, X	;	A[index]+= carry

		ldw	X, Muls_Ai
		incw	X
		ldw	Muls_Ai, X

		incw	Y

		pop	A		;	POP index--
		dec	A
		jrne step@muls

	ldw	X, Muls_carry
	ld	A, XL
	ld	(Y), A

	subw	Y, #SHIFT_RESTORE	;	index C=- A_SIZE_BYTES and C++

	ldw	X, Muls_Ai
	subw	X, #A_SIZE_BYTES	;	index A=- A_SIZE_BYTES
	ldw	Muls_Ai, X

next@muls.w
	ldw	X, Muls_Bi		;	index B++
	incw	X
	ldw	Muls_Bi, X

	pop	A			;	POP level--
	dec	A
	jrne level@muls

	ret
;------------------------------------------------------
zero@muls.w
	incw	Y
	jp	next@muls		;	skip level++
;------------------------------------------------------
;		* * *		End of File
;------------------------------------------------------
