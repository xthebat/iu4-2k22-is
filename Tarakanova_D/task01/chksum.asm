; int chksum(uint8_t* buf, int size)
; uint8_t* rcx, int edx
; return rax
chksum:
	push rbx
	mov rbx, rcx			; rbx = rcx
	
loop:
	movzx r8d, byte [rbx] 	; r8 = *(uint8_t*)rbx
	add r9d, r8d		 	; r9d += r8d
 
	add rbx, 1 				; rbx += 1
	sub edx, 1 				; edx -= 1  
	cmp edx, 0				; edx <> 0
	jz loop 				; if (zf == 0) goto loop

	pop rbx  				; <restore rbx>
	
exit:
	mov eax, r9d				; return r9d
	ret 
	