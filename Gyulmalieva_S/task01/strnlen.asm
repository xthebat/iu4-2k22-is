; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX
; const char* rcx
; size t rdx
strnlen:

	push rbx
	
	mov rbx, rcx        ; rbx = rcx

loop:
	mov al, byte [rbx]  ; al = *(uint8_t*)rbx
	add rbx, 1          ; rbx = (uint8_t*)rbx + 1
	test al, al         ; zf = 1 if al == 0
	jz exit             ; if (zf == 1) goto exit
	sub rcx, 1          ; rcx -= 1
	                    ; zf = r8 == 0
	jnz loop            ; if (zf == 0) goto loop

	
exit:
	sub rbx, rcx        ; rbx = rbx - rcx
	add rbx, -1         ; rbx = (uint8_t*)rbx - 1
	mov rax, rbx
	
	pop rbx             ; return rbx
	
	ret