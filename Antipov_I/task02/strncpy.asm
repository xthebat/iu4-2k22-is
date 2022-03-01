SECTION .text 
;char * strncpy( char * destptr, const char * srcptr, size_t num );
    ; rcx -- destptr
    ; rdx -- srcptr
    ; r8 -- num
strncpy:
    mov     rax, rcx
    test    r8, r8
    jz      strncpy_ret
    push    r9

strncpy_loop:
    sub     r8, 1               ; if len(src) > num 
    test    r8,r8
    jz      strncpy_ret

    mov     r9b, byte[rdx]
    mov     byte[rcx], r9b

    add     rcx, 1
    test    r9b, r9b
    jz      strncpy_loop        ; if len(src) < num
    add     rdx, 1
    jmp     strncpy_loop
       
strncpy_ret:
    pop     r9
    ret
