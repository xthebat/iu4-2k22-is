;(destination rcx, source rdx, size r8)
strcpy:

	push rbx
	test r8, r8
	jz result	
	
	mov rbx, rcx 
	
loop:	
	mov al, byte [rdx]
	test al, al
	jz zeros
	
	mov byte [rbx], al	
	inc rdx   		      
	inc rbx						
	dec r8			
	test r8, r8			
	jz result				
	
	jnz loop 			
	
zeros:
	mov byte[rbx], 0	
	inc rbx			
	dec r8			
	test r8, r8
	jnz zeros			
	
result:
	mov rax, rcx 		
	pop rbx

	ret
	