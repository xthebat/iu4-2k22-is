; char*<rax> strstr( const char* str<rcx>, const char* substr<rdx> );

; char *strstr(const char *haystack, const char *needle);
; arguments: RCX, RDX, R8, R9 (calling convention x86) 

strstr:
	push r12
	push r13
	push r14
	push rbx
	
	xor rax,rax
	xor r11,r11
	jmp loop
	
search:
	mov rcx, r14
	mov rbx, rdx
	
loop:
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add r11,1
	add rcx,1
	mov r14, rcx
	test r13b, r13b
	jz return2
	cmp r12b, r13b
	je inner_loop
	jne loop
inner_loop:	
	add rbx,1
	mov r10b, byte[rbx]	
    test r10b,r10b				
	jz return1
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add rcx,1				
	cmp r12b,r13b
	je inner_loop
	
	jne search
return1:
	pop rbx
	pop r14
	pop r13
	pop r12
	mov rax,r11	
	
	ret
	
return2:
	pop rbx
	pop r14
	pop r13
	pop r12
	xor rax,rax				
	
	ret
