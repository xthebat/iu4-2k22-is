;void<eax> *cksum(void *s<rcx>, int *c<edx>)
;return eax

cksum:

	test edx, edx
	jz exit

	xor eax, eax

	push r8
	
	xor r8, r8

	
loop:
	movzx r8d, byte [rcx]	; r8 = *rcx
	add rcx, 1				; rcx = (uint8_t*)rcx + 1
	add eax, r8d			; r8 += eax
	sub edx, 1    			; edx -= 1
							; zf = 1 if edx == 0 
	jnz loop      			; if (zf == 0) goto loop
	
	
	pop r8
	
	
exit:
	
	ret