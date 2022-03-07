strncpy:
	test r8, r8                
	jz exit                    
	push rbx                   
	mov rbx, rcx              
	                           
loop: 
	mov al, byte [rdx]         
	mov byte [rbx], al         
	add rdx, 1                 
	add rbx, 1                 
	test al, al				   	
	jz set_nulls ;если дошли до конца, то идем запонять нулями
	sub r8, 1                  	                           		
	jnz loop
        jz exit                   
	
set_nulls:
	sub r8, 1 				   
	mov byte[rbx], 0		   
	add rbx, 1                 
	cmp r8, 0				   
	jne set_nulls			                       

exit:
	pop rbx
	mov rax, rcx
	
	ret

