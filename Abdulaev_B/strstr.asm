;char * strstr(const char *str1, const char *str2);
func_strstr:
	push rbx                    ; <save> rbx
	mov r10,rdx 				; r10 = rdx

loop:
	mov r8b, byte[rcx]	
	test r8b, r8b               
	jz loop_1					; if zf == 1 goto loop_1
	mov r9b, byte[rdx]			
	mov rbx, rcx				; rbx = rcx
	test r8b, r9b   			; zf = 1 if r8b == r9b
	jz loop_2					; if zf == 1 goto loop_2
	inc rcx					    
	jmp loop					; goto loop
	
loop_1:
	xor rbx, rbx				; rbx = 0
	jmp end
	
loop_2:
	inc rdx					
	inc rcx					
	mov r8b, byte[rcx]			
	mov r9b, byte[rdx]			
	test r9b, r9b               ;if r9b == r9b
	jz end						;if zf == 1 goto end
	test r8b, r9b    			;if r8b == r9b
	jz loop_2					;if zf == 1 goto loop
	mov rdx, r10
	jmp loop
	
end:
	mov rax, rbx				;rax = rbx
	pop rbx                     

	ret