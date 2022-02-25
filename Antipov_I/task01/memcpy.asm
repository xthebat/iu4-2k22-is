SECTION .text 
; void * memcpy( void * destptr, const void * srcptr, size_t num );
memcpy:
    push    r9  
    mov    rax, rcx 
memcpy_cyc:
    test    r8, r8
    jz      memcpy_ret
    sub     r8, 1
    mov     r9b, byte[rdx] 
    add     rdx, 1
    mov     byte [rcx], r9b
    add     rcx, 1
    jmp     memcpy_cyc
memcpy_ret:
    pop r9
    ret
