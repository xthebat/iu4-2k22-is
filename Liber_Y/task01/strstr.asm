; char * strstr( const char * string1, const char * string2 ); ищем string 2 в string1
my_strstr:
	push rbx
	mov rbx,rcx 				; rbx = rcx
	mov r10,rdx 				; r10 = rdx
loop:
	mov r8b, byte[rbx]			;r8b = *rbx
	test r8b, r8b
	jz no_match					;if (r8b==0) goto no_match
	
	mov r9b, byte[r10]			;r9b = *r10
	mov r11, rbx				;r11 = rbx
	cmp r8b, r9b   				;if (r8b==r9b)
	jz match					;goto match
	
	add rbx, 1					;rbx+=1  
	jmp loop					;goto loop
	
no_match:
	xor r11,r11					;r11 = 0
	jmp exit
	
match:
	add r10, 1					;r10+=1
	add rbx, 1					;rbx+=1
	mov r8b, byte[rbx]			;r8b = *rbx
	mov r9b, byte[r10]			;r9b = *r10
	test r9b, r9b   
	jz exit						;if (r9b==0) goto exit
	
	cmp r8b, r9b   
	jnz step_back				;if (r8b!=r9b) goto no_match
	
	jz match					;if (r8b==r9b) goto match
	
step_back:
	mov r10, rdx
	jmp loop
exit:
	pop rbx
	mov rax, r11				;return r11
	
	ret
	