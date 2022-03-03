; char * strncpy( char * dest, const char * src, size_t count );
    ; rcx -- указатель на память to
    ; rdx -- указатель на память from
    ; r8 -- сколько
    ; возвращается rcx без изменений

; копирует сюдова оттудава -- num штук


; https://en.cppreference.com/w/c/string/byte/strncpy says that we have to force alot of nulls if |src| < count

SECTION .text
strncpy:
    push r12
    mov rax, rcx
    strncpy_cycle:
        test r8, r8                ; критерий выхода из цикла
        jz strncpy_finish
            mov r12b, byte[rdx]    ; промежуточно перекладываем, у нас нет двойного разыменования
            mov byte [rcx], r12b
            add rcx, 1             ; двигаем указатель по "to"
            sub r8, 1              ; уменьшаем счётчик
            test r12b, r12b        ; if rdx[current] is not null
            jz strncpy_cycle        ; короче план такой, если в "from" встали на нуле, то не двигаем указатель
                add rdx, 1         ; таким образом, всё забивают нулями, как и сказано в замечании наверху
            jmp strncpy_cycle
    strncpy_finish:
    pop r12
ret


