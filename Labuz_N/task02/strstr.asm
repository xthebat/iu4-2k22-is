strstr:
	push r12
	push r13
        push r14
	push rbx
	
	mov rax, 0
	mov r11, 0

back
	mov rcx, r14
        mov rbx, rdx ; начинаем поиск с первого символа подстроки

loop:						
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add r11, 1
	add rcx, 1
        mov r14, rcx 
	test r13b, r13b
	jz exit2
	cmp r12b, r13b
	je inner_loop ; при нахождении первого символа подстроки идем проверять совпадения других символов 
	jne loop

inner_loop:	
	add rbx, 1
        mov r10b, byte[rbx]				
        test r10b, r10b				
	jz exit1 ; если дошли до конца подстроки выходим из цикла
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add rcx, 1				
	cmp r12b, r13b
	je inner_loop
	jne back ; при несовпадении возвращаемся назад

exit1:
        pop rbx
        pop r14
	pop r13
	pop r12
	mov rax,r11	
	
	ret
	
exit2:
        pop rbx
        pop r14
	pop r13
	pop r12
	mov rax,0				
	
	ret
