strstr:
	push r8
	push r9
	push rbx
	xor r8, r8
	xor r9, r9
	xor rbx, rbx
	mov r10, rdx
	
	
start:
	mov rdx, rd

loop:
	
	add R8b, byte [rcx]
	add R9b, byte [rdx]
	test rcx, rcx
	jnz null
	inc rbx
	cmp r8b, r9b
	je loop1
	inc rcx
	jne loop
	
	
loop1:
	inc rcx
	inc rdx
	mov R8b, byte [rcx]
	mov R9b, byte [rdx]
	test r9b, r9b
	jnz exit
	cmp r8b, r9b
	je loop1
	
	jne start

null:
	xor rbx, rbx
	
	
	
exit:
	mov rax, rbx	
	ret

