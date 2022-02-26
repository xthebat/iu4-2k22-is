
; void * memset( void * memptr, int val, size_t num );
    ; rcx -- указатель на память
    ; rdx -- значение (1 байт, т.е. char)
    ; r8 -- сколько
    ; возвращается rcx без изменений

; пишет всю память одним 8бит-символом



; начало
SECTION .text ; Толик посоветовал
memset:
    mov rax, rcx ; ещё раз а зачем оно возвращает эту фигню....
    memset_cycle:
        test r8, r8 ; test ~ AND
        jz memset_finish
            mov byte [rcx], dl ; dl -- младший байт в rdx
            add rcx, 1
            sub r8, 1
            jmp memset_cycle
        memset_finish:
ret
