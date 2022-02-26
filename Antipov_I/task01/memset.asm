SECTION .text 
; void * memset( void * memptr, int val, size_t num );
memset:
    mov     rax, rcx 
memset_cyc:
    test    r8, r8
    jz      memset_ret
    sub     r8, 1
    mov     byte [rcx], dl
    add     rcx, 1
    jmp     memset_cyc
memset_ret:
    ret
