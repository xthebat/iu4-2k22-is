; size_t strnlen( const char *str, size_t numberOfElements);
    ; rcx -- указатель на память
    ; rdx -- оценка сверху на длину строки

    ; возвращает длину строки если она (кроме null) короче чем rdx
    ; иначе возвращает numberOfElements

; отсчитывает до нуль-терминатора


SECTION .text
strnlen:
    push r12
    xor rax, rax                    ; чистим регистр (best practice)
    strnlen_cycle:
        mov r12b, byte[rcx]         ; промежуточный регистр для test чтобы без разыменования
        test r12b, r12b
        jz strnlen_finish
            cmp rdx, rax            ; если счётчик достиг предела
            je strnlen_finish
                add rax, 1          ; увеличиваем счётчик
                add rcx, 1          ; двигаем указатель
                jmp strnlen_cycle
    strnlen_finish:
    pop r12
ret
