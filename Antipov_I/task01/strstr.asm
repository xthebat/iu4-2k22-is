SECTION .text
; char* strstr( const char* str, const char* substr );
strstr:
    push    r10 
    push    r11 
    push    r12  
    push    r13

    xor     rax, rax
    xor     r10b, r10b
    mov     r12b, byte [rdx]
    test    r12b, r12b
    jnz     strstr_global_loop
    mov     rax, rcx
    jmp     strstr_end
         
strstr_global_loop:
    xor     r11b, r11b
strstr_inner_loop:
    ; substr ends
    mov     r12b, byte [rdx + r11] 
    test    r12b, r12b
    jnz     strstr_substr_null
    mov     rax, rcx 
    add     rax, r10b
    jmp     strstr_end 

strstr_substr_null:
    ; str ends
    mov     r12b, byte [rcx + r11]
    test    r12b, r12b
    jnz     strstr_str_null
    xor     rax, rax
    jmp     strstr_end

strstr_str_null:
    mov     r12b, r11b
    add     r12b, r10b
    add     r10b, 1
    mov     r13b, byte [rcx + r12]
    mov     r12b, byte [rdx + r12]
    test    r12b, r13b
    jne     strstr_next_symb
    add     r11b, 1
    jmp     strstr_inner_loop

strstr_next_symb:
    add     r10b, 1
    jmp     strstr_global_loop
strstr_end:
    pop     r13
    pop     r12
    pop     r11
    pop     r10
ret
