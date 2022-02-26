; std::size_t strlen( const char* str )
    ; rcx -- указатель на память
    ; возвращает длину строки

; считает длину до нуль-терминатора


SECTION .text ; Толик посоветовал
strlen:
    push r12
    xor rax, rax ; Толик сказал что-то про длину байт-кодов, я прослезился
    strlen_cycle:
        mov r12b, byte[rcx]
        test r12b, r12b
        jz strlen_finish ; нуль-терминатор
            add rax, 1
            add rcx, 1
            jmp strlen_cycle
    strlen_finish
    pop r12
ret

