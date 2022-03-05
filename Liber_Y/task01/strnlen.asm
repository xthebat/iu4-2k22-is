;size_t strnlen(const char *s, size_t maxlen);
my_strnlen:
	push rbx
	mov rbx, rcx   			;rbx=rcx
	mov r10, rdx  			;r10=rdx
loop:	
	mov al, byte [rbx]		;al=*rbx
	add rbx, 1      		;rbx+=1
	sub r10, 1          	;r10-=1
	test r10, r10     		
	jz exit           		;if (r10==0) goto exit       
	test al, al		  		
	jnz loop          		;if (al!=0) goto loop 
	
	sub rbx, rcx			;rbx=rbc-rcx
	sub rbx, 1				;rbx-=1
	mov rax, rcx			;return rcx
	
	pop rbx
exit:
	mov rax, rdx  			;return rdx	    
	
	ret
	
	
	
