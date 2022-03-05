; char *strstr(const char *haystack, const char *needle);
; const char* rcx, const char* rdx
; return rax
strstr:
	push rbx
	
	mov rbx,rcx 				; rbx = rcx
	mov r9,rdx 					; r9 = rdx
	
loop:
	cmp byte[r9], byte[r9]		; if *(uint8_t*)r9 == 0 <==> zf == 1
	jz y2						; goto y2; else
	cmp byte[rbx], byte[r9] 	; if *(uint8_t*)rbx == *(uint8_t*)r9
	jnz matched					; goto matched; else
	xor rcx,rcx 				; (uint8_t*)rcx = 0
	mov r9, rdx 				; (uint8_t*)r9 = (uint8_t*)rdx
	add rbx, 1 					; (uint8_t*)rbx += 1
	test byte[rbx], byte[rbx] 	; if *(uint8_t*)rbx != 0 <==> zf != 1
	jne loop					; goto to loop
	 
matched:
	cmp rcx, 0 					; if (uint8_t*)rcx != 0 <==> zf != 1
	jne y1 						; goto y1; else
	mov rcx, rbx 				; (uint8_t*)rcx = (uint8_t*)rbx
y1:	
	add r9, 1 					; (uint8_t*)r9 += 1
	add rbx, 1 					; (uint8_t*)rbx += 1
	test byte[rbx], byte[rbx] 	; if *(uint8_t*)rbx != 0 <==> zf != 1
	jne loop					; goto to loop

y2:
	pop rbx, r9 				; <restore rbx, r9>
exit:	
	mov rax, rcx 				; return (uint8_t*)rcx
	ret