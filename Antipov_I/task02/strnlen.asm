SECTION .text
; size_t strnlen( const char *str, size_t numberOfElements)
strnlen:
    push    r9
    xor     rax, rax
strnlen_loop:
    mov     r9b, byte[rcx]
    test    r9b, r9b            ; if *str == '\0'
    jz      strnlen_ret
    cmp     rdx, rax            ; if result == numberOfElements
    je      strnlen_ret
    add     rcx, 1
    add     rax, 1
    jmp     strnlen_loop
strnlen_ret:
    pop r9
    ret
