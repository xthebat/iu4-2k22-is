; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX
; const char* rcx
; size_t<rax> strnlen( const char *str<rcx>, size_t numberOfElements<rdx>);
strlen:
	push rbx	
	mov rbx, rcx        ; rbx = rcx
	xor r10,r10			; r10 == 0
	test rdx,rdx		; zf = rdx == 0
	jz exit
	
loop:
	mov al, byte [rbx]  ; al = *(uint8_t*)rbx
	sub rdx,1	
	add rbx, 1          ; rbx = (uint8_t*)rbx + 1
	add r10,1
	test rdx, rdx
	jz exit
	test al, al         ; zf = al == 0
	jnz loop            ; if (zf == 0) goto loop
	
	sub r10, 1        
exit:

	mov rax,r10	
	pop rbx
	
	ret

