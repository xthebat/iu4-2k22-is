SECTION .text
; char* strstr( const char* str, const char* substr );
strstr:
    push    r10 
    push    r11 
    push    r12  
    push    r13
    push    r14

    xor     rax, rax
    xor     r10, r10
    mov     r12b, byte [rdx]
    test    r12b, r12b
    jnz     strstr_global_loop
    mov     rax, rcx
    jmp     strstr_end
         
strstr_global_loop:
    xor     r11, r11
strstr_inner_loop:
    ; substr ends
    mov     r12b, byte [rdx + r11] 
    test    r12b, r12b
    jnz     strstr_substr_null
    mov     rax, rcx 
    add     rax, r10
    jmp     strstr_end 

strstr_substr_null:
    ; str ends
    mov     r12b, byte [rcx + r11]
    test    r12b, r12b
    jnz     strstr_str_null
    xor     rax, rax
    jmp     strstr_end

strstr_str_null:
    mov     r14, r11
    add     r14, r10
    add     r10, 1
    mov     r13b, byte [rcx + r14]
    mov     r12b, byte [rdx + r14]
    test    r12b, r13b
    jne     strstr_no_match
    add     r11b, 1
    jmp     strstr_inner_loop

strstr_no_match:
    jmp     strstr_global_loop
strstr_end:
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
ret
