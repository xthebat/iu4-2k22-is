;void<eax> *checksum(void *s<rcx>, int *c<edx>)
checksum:
	test rdx, rdx
    xor r9, r9
	jz end
	push rbx
	mov rbx, rcx			;rbx=rcx
loop:
	movzx r8d, byte [rbx] 	;r8d = *rbx
	add r9d, r8d 			;r9d += *rbx
	add rbx, 1 				
	add rdx, -1 				
	jnz loop 				;if rdx!=0 goto loop

	pop rbx  
end:
	mov eax, r9d 			;return r9b
	ret 