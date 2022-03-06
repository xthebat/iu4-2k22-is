; int chksum(uint8_t* buf, int size)
; uint8_t* rcx, int rdx
; return rax
chksum:
	push rbx
	mov rbx, rcx			; rbx = rcx
	
loop:
	mov r8, byte [rbx] 		; r8 = *(uint8_t*)rbx
	add r9, r8			 	; r9 += r8
 
	add rbx, 1 				; rbx += 1
	sub rdx, 1 				; rdx -= 1  
	cmp rdx, 0				; rdx <> 0
	jz loop 				; if (zf == 0) goto loop

	pop rbx  				; <restore rbx>
	
exit:
	mov rax, r9				; return r9
	ret 
	