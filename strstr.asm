;(source1 rcx, source2 rdx) s2 в s1? 
strstr:
	
	push rbx 
	push r12
	mov rbx, rcx
	mov r10, rdx 				
	
loop:
	mov r8b, byte[rcx]			
	test r8b, r8b               
	jz notfound					
	
	mov r9b, byte[rdx]			
	test r9b, r9b
	jz notfound
	
	xor r12,r12
	inc r12
	test r8b, r9b   			
	jnz search					
	
	inc rcx					    
	jmp loop					
	
	
search:
	xor r11, r11
	inc r11
	inc rcx
	inc rdx
	mov r9b, byte[rdx]
	test r9b, r9b
	jz found
	
	mov r8b, byte[rcx] 
	test r8b, r9b		;if r8b = r9b -> zf = 1 -> search
	jnz search
	
	jz fail
	
fail:
	dec r11
	sub rcx, r11		;вычитаем на сколько мы сдвинулись по слову в котором ищем = возврат к началу+1 байт
	mov rdx, r10
	jmp loop

found:
	pop rbx 
	mov rax, r12				              

	ret
	
notfound:
	pop rbx 
	xor rax, rax				                

	ret