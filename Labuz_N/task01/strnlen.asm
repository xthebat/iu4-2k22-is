strnlen:
	push rbx
	push r10
	mov r10, 0	
	mov rbx, rcx       
	
loop:
	mov al, byte [rbx]
	sub rdx, 1
	test rdx, rdx
	jz exit2  ; выходим если обнулился счетчик (буфер)
	add rbx, 1
	add r10, 1 
	test al, al         
	jnz loop         	

exit1:						
	
	mov rax, r10       
    pop r10
    pop rbx

    ret

exit2:
	
	mov rax, rdx
	pop r10	
	pop rbx
	
	ret