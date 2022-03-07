strnlen:
	push rbx
	mov r10, 0	
	mov rbx, rcx
        test rdx, rdx
        jz exit       
	
loop:
	mov al, byte [rbx]
	sub rdx, 1
	add rbx, 1
	add r10, 1
	test rdx, rdx
	jz exit  ; выходим если обнулился счетчик (буфер) 
	test al, al         
	jnz loop         	
	
        sub r10, 1

exit:							
        mov rax, r10       
        pop rbx

        ret
