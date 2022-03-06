; char *strncpy(char *dest, const char *src, size_t n);
; char *rcx, const char *rdx, size_t r8
; return rax
strncry:
	test r8, r8					; r8 <> 0
	jnz	exit					; if (zf == 1) goto loop
	
	push rbx
	
	mov rbx, rcx 				; rbx = (uint8_t*)rcx
	mov r10, rdx				; r10 = (uint8_t*)rdx
								
loop:
	mov r9, r10					; r9 = r10
	sub r9, rdx					; r9 = r9 - rdx
	cmp r9, r8					; r9 <> r8
	jnz exit1					; if (r9 == r8) goto exit1
	
	mov al, byte[r10] 			; al = *(uint8_t*)r10
	mov byte[rbx], al 			; *rbx = al
	add r10, 1 					; (uint8_t*)r10 += 1
	add rbx, 1 					; (uint8_t*)rbx += 1
	
	test al, al 				; zf = al == 0
	jz loop1					; if (zf == 1) goto loop1
	jmp loop					; goto loop

loop1:
	mov r9, r10					; r9 = r10
	sub r9, rdx					; r9 = r9 - rdx
	cmp r9, r8					; r9 <> r8
	jnz exit1					; if (r9 == r8) goto exit1
	
	mov byte[rbx], 0 			; *rbx = 0
	add rbx, 1 					; (uint8_t*)rbx += 1
	
	jmp loop1					; goto loop1

exit1:	
	pop rbx						; <restore rbx>

exit:	
	mov rax, rcx				; return rcx
	ret
	
	