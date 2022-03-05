;void<rax> *strncpy(char *dest<rcx>, const char *src<rdx>, size_t n<r8>)
;return rax

strncpy:

	test r8, r8
	jz exit

	push rbx
	
	mov rbx, rcx
	
loop:
	mov al, byte [rdx]         ; al = *rdx
	test al, al                ; zf = al == 0
	jz null                    ; if (zf == 1) goto null
	mov byte [rbx], al         ; *rbx = al
	add rdx, 1                 ; rdx += 1
	add rbx, 1                 ; rbx += 1
	sub r8, 1                  ; r8 -= 1
	                           ; zf = r8 == 0
	jnz loop                   ; if (zf == 0) goto loop
	
null:
	mov byte[rbx], 0
	add rbx, 1                 ; rbx += 1
	sub r8, 1                  ; r8 -= 1
	jnz null                   ; if (zf == 0) goto null
	
	
	pop rbx
	
exit:
	mov rax, rcx
	
	
	ret