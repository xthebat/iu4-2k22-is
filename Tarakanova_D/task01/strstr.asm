; char *strstr(const char *haystack, const char *needle); имена аргументов взяты с https://linux.die.net/ :)
; const char* rcx, const char* rdx
; return rax
strstr:
	push rbx
	
	mov rbx, rcx 				; rbx = rcx
	mov r9, rdx 				; r9 = rdx
	mov r11, 0					; r11 = 0
	
loop:
	mov r8b, byte [r9]			; r8b = *(uint8_t*)r9
	test r8b, r8b				; if *(uint8_t*)r9 == 0 <==> zf == 1
	jz exit						; goto exit; else
	
	mov r10b, byte[rbx]			; r10b = *(uint8_t*)rbx
	cmp r10b, r8b				; if *(uint8_t*)rbx == *(uint8_t*)r9 <==> zf == 1
	jz matched					; goto matched; else
	
	cmp r11, 0 					; if (uint8_t*)r11 == 0 <==> zf != 0
	jnz unmatchedbefore			; goto unmatchedbefore; else
	mov rbx, r11				; (uint8_t*)rbx = (uint8_t*)rcx
	
unmatchedbefore:
	xor r11,r11					; (uint8_t*)r11 = 0
	mov r9, rdx 				; (uint8_t*)r9 = (uint8_t*)rdx
	add rbx, 1 					; (uint8_t*)rbx += 1
	mov r10b, byte[rbx]			; r10b = *(uint8_t*)rbx
	test r10b, r10b				; if *(uint8_t*)rbx != 0 <==> zf != 1
	jne loop					; goto to loop
	jmp notfounded				; goto notfounded
	
matched:
	cmp r11, 0 					; if (uint8_t*)r11 != 0 <==> zf != 1
	jne matchedbefore 			; goto matchedbefore; else
	mov r11, rbx 				; (uint8_t*)rcx = (uint8_t*)rbx
	
matchedbefore:	
	add r9, 1 					; (uint8_t*)r9 += 1
	add rbx, 1 					; (uint8_t*)rbx += 1
	mov r10b, byte[rbx]			; r10b = *(uint8_t*)rbx
	
	test r9, r9					; if *(uint8_t*)rdx == 0 <==> zf == 1
	jnz exit					; goto exit
	
	test r10b, r10b				; if *(uint8_t*)rbx != 0 <==> zf != 1
	jne loop					; goto to loop
	
notfounded:
	mov r11, 0					; (uint8_t*)r11 = 0
		
exit:
	pop rbx						; <restore rbx>
	mov rax, r11 				; return (uint8_t*)r11
	ret