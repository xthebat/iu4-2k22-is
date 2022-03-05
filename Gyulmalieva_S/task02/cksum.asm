;void<rax> *cksum(void *s<rcx>, int *c<rdx>)
;return rax

cksum:

	test rdx, rdx
	jz exit

	push r8
	
	xor r8, r8

	
loop:
	movzx r8, byte [rcx]	; r8 = *rcx
	add rcx, 1				; rcx = (uint8_t*)rcx + 1
	add rax, r8				; r8 += 1
	sub rdx, 1    			; rdx -= 1
							; zf = 1 if r8 == 0 
	jnz loop      			; if (zf == 0) goto loop
	
	
	pop r8
	
	
exit:
	
	ret