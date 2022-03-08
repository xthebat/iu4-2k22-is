strncpy:
	mov rax, 0
	test r8, r8
	jz exit
	
	push rbx
	mov rbx, rcx
	
	
loop:
	mov al, byte [rdx]
	mov byte[rbx], al
	test al, al
	jz exit2
	inc rbx
	inc rdx
	dec r8
	test r8, r8
	jz exit
	jnz loop
	
		
	

exit2:
	
	mov byte[rbx], 0
	add rbx, 1               
	sub r8, 1                  
	jnz exit2                  
	
exit:
	mov rax, rcx
	pop rbx
	ret