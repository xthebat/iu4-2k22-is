; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax
; function strnlen ( const char *s, size_t maxlen )

strnlen:
    push rbx
    push r14
    mov rbx, rcx
    mov r14, rdx

loop:
    mov al, byte [rbx]
    add rcx, 1    

    cmp rcx, r14            ; if ( rcx == r14 ) 
    jz  return_value        ; goto return_value

    test al, al
    jnz loop 

return_value:
    sub rbx, rcx
    add rcx, -1
    mov rax, rcx

    pop r14
    pop rbx
    ret