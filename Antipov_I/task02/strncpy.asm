SECTION .text 
;char * strncpy( char * destptr, const char * srcptr, size_t num );
strncpy:
    mov     rax, rcx
    test    r8, r8
    jz      strncpy_ret
    push    r9

strncpy_loop:
    mov     r9b, byte[rcx]              ; if *destptr == '\0'
    test    r9b, r9b
    jz      strncpy_ret
    add     rcx, 1 

    mov     r9b, byte[rdx]              ; if *srcptr == '\0'
    test    r9b, r9b
    jz      strncpy_skip
    add     rdx, 1

strncpy_skip:
    sub     r8, 1
    test    r8,r8
    jz      strncpy_ret
    jmp     strncpy_loop
       
strncpy_ret:
    pop     r9
    ret
