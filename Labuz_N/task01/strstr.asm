strstr:
	push r11
	push r12
	push r13
	push rbx
	
	mov rax, 0
	mov r10, 0

back
	mov rbx, rdx ; начинаем поиск с первого символа подстроки

loop:						
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add r11, 1
	add rcx, 1 
	test rcx, rcx
	jz return2
	cmp r12b, r13b
	je inner_loop ; при нахождении первого символа подстроки идем проверять совпадения других символов 
	jne loop

inner_loop:	
	add rbx, 1				
    test rbx, rbx				
	jz return1
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add rcx, 1				
	cmp r12b, r13b
	je inner_loop
	jne back ; при несовпадении возвращаемся назад

exit1:
    push rbx
	push r13
	push r12
	push r11
	mov rax,r11	
	
	ret
	
exit2:
    push rbx
	push r13
	push r12
	push r11
	mov rax,0				
	
	ret
