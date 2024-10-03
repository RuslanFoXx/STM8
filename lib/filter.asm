;------------------------------------------------------
;	Low Filter
;	Function Version 1.xx (STM8S003F3P)
;	For STVD MainFrame Version 3.6.5.2
;	(c) Kyiv, Ruslan FoXx
;	01 October 2024
;------------------------------------------------------
;	ldw Low_Scale,  #Buffer_A
;	ldw Low_Buffer, #Buffer_B
;	ldw Low_Result, #Buffer_C
;------------------------------------------------------
filter.l
	ld		A, #LOW_BUFFER_SIZE

index@filtern.w
	push	A

	clrw	X
	ldw		Low_integrator,  X	;	integrator = 0
	ldw		Low_integrator2, X

	ld		A, [Low_Scale]
	ld		Low_level, A

	ldw		X, Low_Buffer
	ld		A, #INTEGRATOR_FRAME_SIZE

integrator@filtern.w
		push	A
		pushw	X

		ldw		X, (X)
		ld		A, XH
		ld		YL, A
		ld		A, Low_level
		mul		X, A			;	X = frame.b1 * scale[index]
		mul		Y, A			;	Y = frame.b2 * scale[index]

		ld		A, XL
		add		A, Low_integrator ; integrator[0]+= XL
		ld		Low_integrator, A

		ld		A, XH
		adc		A, Low_integrator1
		ld		Low_integrator1, A

		ld		A, YL
		adc		A, Low_integrator1 ; integrator[1]+= YL + XH
		ld		Low_integrator1, A

		ld		A, YH
		adc		A, Low_integrator2 ; integrator[2]+= YH
		ld		Low_integrator2, A

		clr		A
		adc		A, Low_integrator3 ; integrator[3]+= carry
		ld		Low_integrator3, A

		inc		Low_level		;	scale++

		popw	X				;	frame++
		incw	X

		pop		A				;	index++
		dec		A
		jrne integrator@filtern

	ldw		X, Low_integrator2	;	result[pos]= integrator >> 16
	ldw		[Low_Result], X

	ldw		X, #2
	addw	X, Low_Result		;	result+= word_size
;	ldw		Low_Result, X

	ldw		X, #2
	addw	X, Low_Buffer		;	frame+= word_size
;	ldw		Low_Buffer, X

	pop		A
	dec		A
	jrne index@filtern

	ret
;------------------------------------------------------
;		* * *		End of File
;------------------------------------------------------