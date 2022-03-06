;void<rax> *strstr(const char *src<rcx>, const char *src<rdx>)
;return rax

strstr:

	push rbx
	
loop:

	mov r8b, byte[rcx]			; r8b = *rcx
	test r8b, r8b               ; zf = 1 if r8b == 0
	jz loop1					; if (zf == 1) goto loop1
	
	mov r9b, byte[rdx]			; r9b = *rdx
	mov rbx, rcx				; rbx = rcx
	test r8b, r9b   			; zf = 1 if r8b == r9b
	jz loop2					; if (zf == 1) goto loop2
	
	add rcx, 1					; rcx += 1  
	jmp loop					; goto loop
	
	
loop1:

	xor rbx, rbx				; rbx = 0
	jmp exit
	
	
loop2:

	add rdx, 1					; rdx += 1
	add rcx, 1					; rcx += 1
	mov r8b, byte[rcx]			; r8b = *rcx
	mov r9b, byte[rdx]			; r9b = *rdx
	
	test r9b, r9b               ; zf = 1 if r9b == r9b
	jz exit						; if (zf == 1) goto exit
	
	test r8b, r9b    			; zf = 1 if r8b == r9b
	jz loop2					; if (zf == 1) goto loop2

	sub rdx, 1
	jmp loop
	
	
exit:
	mov rax, rbx				; rax = rbx
	
	pop rbx

	ret
	
	
	