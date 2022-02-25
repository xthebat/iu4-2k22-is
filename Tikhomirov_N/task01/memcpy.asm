; void * memcpy( void * destptr, const void * srcptr, size_t num );
    ; rcx -- указатель на память
    ; rdx -- значение (1 байт, т.е. char)
    ; r8 -- сколько
    ; возвращается rcx без изменений

; копирует сюдова оттудава -- num штук


SECTION .text ; Толик посоветовал
memcpy:
    push r12
    mov rax, rcx ; ещё раз а зачем оно возвращает эту фигню....
    memcpy_cycle:
        test r8, r8 ; test ~ AND
        jz memcpy_finish
            mov r12, byte[rdx] ; перекладуваем
            mov byte [rcx], r12b ; младший байт в r12
            add rcx, 1
            add rdx, 1
            sub r8, 1
            jmp memcpy_cycle
    memcpy_finish:
    pop r12
ret


