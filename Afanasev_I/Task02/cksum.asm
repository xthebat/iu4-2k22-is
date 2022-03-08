cksum:
	mov rax, 0
	test rdx, rdx
	jz exit
	
	push rbx
	mov rbx, rcx
	
loop:
	mov r8b, byte[rbx]
	add rax, r8b
	inc rbx
	dec rdx
	test rdx, rdx
	jnz loop
	
	
	pop rbx
	
exit:
	
	ret