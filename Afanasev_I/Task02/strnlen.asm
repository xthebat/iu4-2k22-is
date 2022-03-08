strnlen:
	mov rax, 0
	test rdx, rdx
	jz exit
	
	push rbx
	mov rbx, rcx
	
	
loop:
	mov al, byte [rbx]
	test al, al
	jz exit2
	inc rbx
	dec rdx
	test rdx, rdx
	jz exit 1
	jnz loop
	
		
	
exit1:
	mov rax, rdx
	jmp exit
	
exit2:
	
	sub rbx, rcx        
	dec rbx      
	mov rax, rbx
	
	pop rbx
	
exit:
	ret

	