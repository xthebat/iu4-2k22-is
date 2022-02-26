; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX

; void<rax> *memset(void *s<rcx>, int c<rdx>, size_t n<r8>);
; |              rdx                 |   64    8 byte
; |               |       edx        |   32    4 byte
; |               |        |   dx    |   16    2 byte
; |               |        | dh | dl |    8    1 byte           
memset:
	test r8, r8            ; zf = r8 == 0
	jz exit                ; if (zf == 1) goto exit
	push rbx               ; <save rbx>
	mov rbx, rcx	       ; rbx = (uint8_t*) rcx
loop:
	; dl = (uint8_t) edx;
	mov byte [rbx], dl     ; *rbx = dl;
	add rbx, 1             ; rbx += 1
	sub r8, 1              ; r8 -= 1
	                       ; zf = r8 == 0
	jnz loop               ; if (zf == 0) goto loop
	pop rbx                ; <restore rbx>
exit:
	; The memset() function returns a pointer to the memory area s.
	mov rax, rcx           ; rax = rcx <-> return rcx
	ret
	