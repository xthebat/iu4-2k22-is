; char* strstr( const char* str, const char* substr );
    ; rcx -- указатель на базу
    ; rdx -- указатель на кринж
    ; возвращается:
        ;1 указатель на начало первого вхождения кринжа в базу
        ;2 null если вхождения нет
        ;3 str если substr пустая

; поиск подстроки в строке

; cppreference says:
    ; The behavior is undefined if either str or substr is not a pointer to a null-terminated byte string.
    ; so relax and chill

SECTION .text ; Толик посоветовал
strstr:
    push r10 ; base_len
    push r11 ; inner len
    push r12 ; for awesome calculations
    push r13 ; for more awesome calculations
    mov rax, 0 ; no found = default 0
    mov r10, 0
    mov r12b, byte [rdx] ; if case == case 3 (substr is empty)
    test r12b, r12b
    jnz strstr_global_loop
        mov rax, rcx ; case 3
        jmp strstr_end ; ------------------------------------------------>
    strstr_global_loop: ; let us use naive implementation with O(m*n) time complexity (please don't tell to Vlagislav Olegovich Chesnokov about this)
        mov r11, 0
        strstr_inner_loop:
            ; if cringe was null-terminated
                mov r12b, byte [rdx + r11] 
                test r12b, r12b
                jnz strstr_skip_cringe_nullterminated
                    mov rax, rcx ; case 1
                    add rax, r10
                    jmp strstr_end ; ---------------------------------------->
                    strstr_skip_cringe_nullterminated:
            ; if base was null-terminated
                mov r12b, byte [rcx + r11]
                test r12b, r12b
                jnz strstr_skip_base_nullterminated
                    mov rax, 0 ; case 2
                    jmp strstr_end ; ---------------------------------------->
                    strstr_skip_base_nullterminated:
            ; if (base eq cringe) + else
                mov r12, r11
                add r12, r10
                mov r13b, byte [rcx + r12] ; if base[global + inner] == cringe[inner]
                mov r12b, byte [rdx + r11]
                test r12b, r13b
                jne strstr_inners_not_equal
                    add r11, 1      ; loop inner
                    jmp strstr_inner_loop
                    strstr_inners_not_equal:
                    add r10, 1      ; loop outer
                    jmp strstr_global_loop
strstr_end:
    pop r13
    pop r12
    pop r11
    pop r10
ret



