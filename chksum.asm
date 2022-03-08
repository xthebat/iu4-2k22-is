;(rcx, edx)
chksum:

	test edx, edx
	jz result

	xor eax, eax
	xor r8, r8
	
loop:
	movzx r8d, byte [rcx]
	inc rcx	
	dec edx   			
	add eax, r8d
	test edx, edx 
	jnz loop      				
	
result:

	ret 