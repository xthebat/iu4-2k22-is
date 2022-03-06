;size_t strnlen(const char *s, size_t maxlen);
my_strnlen:
	push rbx
	test rdx, rdx			;if (rdx==0) goto max_len 
	jz max_len				
	
	mov rbx, rcx   			;rbx=rcx
loop:	
	mov al, byte [rbx]		;al=*rbx
	add rbx, 1      		;rbx+=1      
	test al, al		  		
	jnz loop          		;if (al!=0) goto loop 
	
	sub rbx, rcx			;rbx=rbc-rcx
	sub rbx, 1				;rbx-=1
	cmp rbx, rdx
	jge max_len
	
	jl exit
	
max_len:
	mov rbx, rdx
exit:
	mov rax, rbx  			;return rdx	   
	pop rbx
	
	ret
	
	
	
