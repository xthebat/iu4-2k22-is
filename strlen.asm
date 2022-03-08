;(rcx, size rdx)
strlen:

	push rbx
	test rdx, rdx			
	jz max_len
	
	mov rbx, rcx
	
loop:	
	mov al, byte [rbx]		
	test al, al		  		
	jz result 
	
	inc rbx			
	dec rdx				
	test rdx, rdx
	jnz loop

max_len:
	mov rbx, rdx
	
result:
	sub rbx, rcx
	mov rax, rbx  			  
	pop rbx
	
	ret
	