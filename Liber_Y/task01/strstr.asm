; char * strstr( const char * string1, const char * string2 );

my_strstr:
	push rbx
	mov rbx,rcx 				; rbx = rcx
	mov r10,rdx 				; r10 = rdx
loop:
	cmp byte[rbx], byte[r10]    ;if (*rbx==*r10)
	jz match					;goto match
	
	add rbx,1					;rbx+=1
	test byte[rbx], byte[rbx]	;if (*rbx==0)  
	jz no_match					;goto no_match
	
	mov r11, rbx				;r11 = rbx
	jz loop						;goto loop
no_match:
	mov rax, 0					;return 0
match:
	add r10,1					;r10+=1
	add rbx,1					;rbx+=1
	test byte[r10], byte[r10]   
	jz exit						;if (*r10==0) goto exit
	
	cmp byte[rbx], byte[r10]    
	jnz no_match				;if (*rbx!=*r10) goto no_match
	
	jz match					;if (*rbx==*r10) goto match
	
exit:
	pop rbx
	mov rax, r11				;return r11

	ret
	
	
	