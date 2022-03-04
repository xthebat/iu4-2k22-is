; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX
; const char* rcx
; size_t<rax> strnlen( const char *str<rcx>, size_t numberOfElements<rdx>);
strlen:
	push rbx
	push r10
	
	mov rbx, rcx        ; rbx = rcx
	xor r10,r10			; r10 == 0
	
loop:
	mov al, byte [rbx]  ; al = *(uint8_t*)rbx
	sub rdx,1
	test rdx,rdx		; zf = rdx == 0
	jz return2
	add rbx, 1          ; rbx = (uint8_t*)rbx + 1
	add r10,1
	test al, al         ; zf = al == 0
	jnz loop            ; if (zf == 0) goto loop

	sub rbx, rcx        ; rbx = rbx - rcx
	add rbx, -1         ; rbx = (uint8_t*)rbx - 1
	
return1:						
	mov rax, r10        ; rax = rbx  / return rbx
	pop r10
	pop rbx
	
	ret
return2:
	mov rax,rdx	
	pop r10
	pop rbx
	
	ret

