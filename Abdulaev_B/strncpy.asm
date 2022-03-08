;void<rax> *strncpy(char *dest<rcx>,const char *src<rdx>,size_t n<r8>);
func_strncpy:
	mov rax, 0
	test r8, r8
	jz end
	push rbx            ; save rbx
	mov rbx, rcx
		
loop:	
	mov al, byte [rdx]	; al=*(uint8_t *) rdx
	mov byte [rbx], al	
	inc rdx        		;rdx++      
	inc rbx			    ;rbx++ 
	test al, al   	
	jz zero				;if al==0 goto zero	
	
	sub r8, 1			
	test r8, r8			
	jz end				;if r8==0 goto end
	jnz loop 			;if al!=0 goto loop
		
zero:
	mov byte[rbx], 0
	inc rbx               
	add r8, -1 
    test r8, r8                 
	jnz zero                  
	
end:
	pop rbx
    mov rax, rcx
	ret 