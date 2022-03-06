; size_t strnlen(const char *s, size_t maxlen);
; const char* rcx, size_t rdx
; return rax
strnlen:
	push rbx
	
	mov rbx,rcx 				; rbx = rcx
	
loop:
	mov r8, rbx					; r8 = rbx
	sub r8, rcx					; r8 = r8 - rcx
	cmp r8, rdx					; r8 <> rdx
	jnz exit					; if r8 == rdx goto exit
	
	mov al, byte[rbx] 			; al= *(uint8_t*)rdx
	add rbx, 1 					; (uint8_t*)rbx += 1
	test al, al 				; zf = al == 0
	
	jnz loop					; if (zf == 1) goto loop

	add rbx, -1					; rbx = (uint8_t*)rbx-rcx	
	sub rbx, rcx				; rbx = rbx-rcx
	mov r8, rbx					; r8 = rbx
	
exit:	
	mov rax, r8					; return r8
	pop rbx						; <restore rbx>
	ret