my_chksum:
	push rbx
	mov rbx, rcx			;rbx=rcx
	
loop:
	add r10, byte [rbx] 	;r10 += *rbx
	add rbx, 1 				;rbx+=1
	sub rdx, 1 				;rdx-=1  
	jnz loop 				;if (rdx!=0) goto loop

	pop rbx  
exit:
	mov rax, r10 			;return r10
	
	ret
