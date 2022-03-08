  fun_strnlen:
	push rbx
	test rdx, rdx			;if rdx==0 goto max_lenght 
	jz max_length			;переход, если  равно 0
	mov rbx, rcx   			;rbx=rcx
loop:	
	mov al, byte [rbx]		;al=*(uint8_t *) rbx
	inc rbx     		    ;rbx++    
	test al, al		  		
	jnz loop          		;if al!=0 goto loop 
	
	sub rbx, rcx			;rbx=rbc-rcx
	add rbx, -1			
	cmp rbx, rdx
	jae max_length          ; Jump max_lenght
	jmp end
	
max_length:
	mov rbx, rdx

end:
	mov rax, rbx  			; return rdx	   
	pop rbx
	ret