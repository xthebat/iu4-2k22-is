chksum:	
	push rbx     
	mov rax, 0
        test rdx, rdx
        jz exit

loop: 
	mov bl, byte [rcx]         
	add rax, bl
	add rcx, 1				   
	sub rdx, 1                 	                          							   
	jnz loop                   	

exit:
	pop rbx	
	ret