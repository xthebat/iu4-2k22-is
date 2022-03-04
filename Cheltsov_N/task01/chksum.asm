; int<rax> chksum(uint8_t* buf <rcx>, int size<rdx>) {
; 	int result = 0;
; 	for (int k = 0; k < size; k++) {
; 		result += buf[k];
; 	}
; 	return result;
; } 

; arguments: RCX, RDX, R8, R9 (calling convention x86) 
; return: RAX
chksum:
	push rbx
	
	mov rbx, rcx        ; rbx = rcx
	xor rax, rax
loop: 
	mov al, byte [rbx]         ; al = *rbx
	
	add rax, al				   ; rax +=al
	sub rdx, 1                 ; rdx -= 1
	                           ; zf = rdx == 0
							   
	jnz loop                   ; if (zf == 0) goto loop
	
	pop rbx
	
	ret