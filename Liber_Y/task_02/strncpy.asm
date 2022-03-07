;char * strncpy( char * destptr, const char * srcptr, size_t num );
my_strncpy:
	push rbx
	test r8, r8
	jz exit				;(if r8==0) goto exit
	
	mov rbx, rcx  		;rbx=rcx
loop:	
	mov al, byte [rdx]	;al=*rdx
	mov byte [rbx], al	;*rbx=al
	add rdx, 1    		;rdx+=1       
	add rbx, 1			;rbx+=1 
	test al, al   	
	jz null				;if (al==0) goto null	
	
	sub r8, 1			;r8-=1
	test r8, r8			
	jz exit				;if (r8==0) goto exit
	
	jnz loop 			;if (al!=0) goto loop
	
null:
	mov byte[rbx], 0	;*rbx=0
	add rbx, 1			;rbx+=1
	sub r8, 1			;r8-=1
	test r8, r8
	jnz null			;if (r8!=0) go to null
	
exit:
	mov rax, rcx 		;return rcx
	pop rbx

	ret
