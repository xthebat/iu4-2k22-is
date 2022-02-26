; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX
; const char* rcx
strlen:
	push rbx
	
	mov rbx, rcx        ; rbx = rcx
	
loop:
	mov al, byte [rbx]  ; al = *(uint8_t*)rbx
	add rbx, 1          ; rbx = (uint8_t*)rbx + 1
	test al, al         ; zf = al == 0
	jnz loop            ; if (zf == 0) goto loop
	
	sub rbx, rcx        ; rbx = rbx - rcx
	add rbx, -1         ; rbx = (uint8_t*)rbx - 1
	mov rax, rbx        ; rax = rbx  / return rbx
	
	pop rbx
	
	ret
	
	
	