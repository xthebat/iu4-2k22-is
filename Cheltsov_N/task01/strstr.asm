; char*<rax> strstr( const char* str<rcx>, const char* substr<rdx> );

; char *strstr(const char *haystack, const char *needle);
; arguments: RCX, RDX, R8, R9 (calling convention x86) 

strstr:
	push r10
	push r11
	push r12
	push r13
	push rbx
	
	xor rax,rax
	xor r10,r10
exit
	mov rbx, rdx 			; п
loop:						; Паша ест паштет				найти: ПАШТЕТ
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add r10,1
	add rcx,1 ; a								Паша ест паштет
	test rcx,rcx
	jz return2
	cmp r12b, r13b
	je inner_loop
	jne loop
inner_loop:	
	add rbx,1				; a		ш		т						Паштет
    test rbx,rbx				; zf=rbx == 0
	jz return1
	mov r12b, byte[rbx]
	mov r13b, byte[rcx]
	add rcx,1				; ш		а		''						Паша ест паштет
	cmp r12b,r13b
	je inner_loop
	
	jne exit
return1:
	mov rax,r10	
	
	ret
	
return2:
	mov rax,0				; no matches
	
	ret
