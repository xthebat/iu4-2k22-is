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
	
	mov rax, 0       
	test rdx, rdx
	jz exit
	
	
loop: 
	mov bl, byte [rcx]        
	
	add rax, bl				   
	add rcx, 1
    sub rdx,1

	jnz loop                   

exit:	
	pop rbx
	ret