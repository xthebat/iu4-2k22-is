;void<rax> *memcpy(void *dest<rcx>, const void *src<rdx>, size_t n<r8>)
memcpy:
	test r8, r8                ; zf = r8 == 0
	jz exit                    ; if (zf == 1) goto exit

	push rbx                   ; <save rbx>
	
	mov rbx, rcx               ; rbx = (uint8_t*) rcx
	                           ; rdx = (uint8_t*) rdx
loop: 
	mov al, byte [rdx]         ; al = *rdx
	mov byte [rbx], al         ; *rbx = al
	add rdx, 1                 ; rdx += 1
	add rbx, 1                 ; rbx += 1
	sub r8, 1                  ; r8 -= 1
	                           ; zf = r8 == 0
	jnz loop                   ; if (zf == 0) goto loop
	
	pop rbx                    ; <restore rbx>

exit:
; The memcpy() function returns a pointer to dest.
	mov rax, rcx

	ret
	