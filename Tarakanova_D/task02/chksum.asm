; int chksum(uint8_t* buf, int size)
; uint8_t* rcx, int edx
; return rax
chksum:
	push rbx
	mov rbx, rcx			; rbx = rcx
	mov r9d, 0				; (int)r9d = 0
	
	test edx, edx			; edx <> 0
	jz exit					; if (edx == 0) goto exit <==> zf == 1

loop:
	
	movzx r8d, byte [rbx] 	; (int)r8 = *(uint8_t*)rbx
	add r9d, r8d		 	; (int)r9d += (int)r8d
 
	add rbx, 1 				; rbx += 1
	sub edx, 1 				; edx -= 1  
	cmp edx, 0				; edx <> 0
	jz loop 				; if (zf == 0) goto loop
	
exit:
	pop rbx  				; <restore rbx>
	mov eax, r9d			; return r9d
	ret 
	