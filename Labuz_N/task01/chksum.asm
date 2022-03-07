chksum:	
	push rbx     
	mov rax, 0

loop: 
	mov bl, byte [rcx]         
	add rax, bl
	add rcx, 1				   
	sub rdx, 1                 	                          							   
	jnz loop                   
	
	pop rbx
	
	ret