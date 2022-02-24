SECTION .text
; std::size_t strlen( const char* str )
strlen:
    push    r9
    xor     rax, rax ; mov rax, 0
strlen_cyc:
    mov     r9b, byte[rcx]
    add     rcx, 1
    test    r9b, r9b
    jz      strlen_ret
    add     rax, 1
    jmp     strlen_cyc
strlen_ret:
    pop r9
    ret
    