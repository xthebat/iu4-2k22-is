;void<rax> *memcpy(void *dest<rcx>, const void *src<rdx>, size_t n<r8>)  char *strncpy(char *dest, const char *src, size_t n);

;char * 
;strncpy(char *dest<rcx>, const char *src<rdx>, size_t n<r8>)
;{
;    size_t i;
;
;  for (i = 0; i < n && src[i] != '\0'; i++)
;        dest[i] = src[i];
;   for ( ; i < n; i++)
;       dest[i] = '\0';
;
;  return dest;
;}

strncpy:
	test r8, r8                ; zf = r8 == 0 				размер в байтах
	jz exit                    ; if (zf == 1) goto exit

	push rbx                   ; <save rbx>
	
	mov rbx, rcx               ; rbx = (uint8_t*) rcx   	куда копируем
	                           ; rdx = (uint8_t*) rdx		что копируем
loop: 
	mov al, byte [rdx]         ; al = *rdx
	
	mov byte [rbx], al         ; *rbx = al
	add rdx, 1                 ; rdx += 1
	add rbx, 1                 ; rbx += 1
	test al,al				   ; zf = al == 0	
	jz add_nulls	
	sub r8, 1                  ; r8 -= 1
	                           ; zf = r8 == 0

	
	
	jnz loop                   ; if (zf == 0) goto loop
	
add_nulls:
	sub r8, 1 				   ; r8 -= 1
	mov byte[rbx], 0		   ; rbx = '\0'
	add rbx, 1                 ; rbx +=1
	cmp r8,0				   ; if r8 != 0 
	jne add_nulls			   ; прыгаем на цикл add_nulls
	
	pop rbx                    ; <restore rbx>

exit:
; The strncpy() function returns a pointer to dest.
	mov rax, rcx
	
	ret

