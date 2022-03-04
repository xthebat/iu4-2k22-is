chksum:
	
	push rbx
	mov rbx, rcx       
	mov rax, 0

loop: 
	mov al, byte [rbx]         
	add rax, al
	add rbx, 1				   
	sub rdx, 1                 	                          							   
	jnz loop                   
	
	pop rbx
	
	ret