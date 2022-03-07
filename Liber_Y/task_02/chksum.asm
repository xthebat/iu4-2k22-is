my_chksum:
	xor r9, r9
	test rdx, rdx
	jz exit
	
	push rbx
	mov rbx, rcx			;rbx=rcx
loop:
	movsx r8d, byte [rbx] 	;r8d = *rbx
	add r9d, r8d 			;r9d += *rbx
	add rbx, 1 				;rbx+=1
	sub rdx, 1 				;rdx-=1 
	jnz loop 				;if (rdx!=0) goto loop

	pop rbx  
exit:
	mov eax, r9d 			;return r9b
	
	ret