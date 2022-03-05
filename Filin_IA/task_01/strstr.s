; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax
; function strncpy ( const char * string1, const char * string2 )

strstr:
    push r9
    push r10            
    push r11
    push r12

    mov r12, rdx
    mov rbx, rcx
    xor r9, r9                      ; зануление счетчика длины строки
    xor rcx, rcx                    ; зануление счетчика

loop_lenght_search:
    mov al, [r8]
    add r9, 1
    add r8, r9
    test al, al
    jnz loop_lenght_search
; r9 хранит в себе длину строки, которая должна входить в поле поиска

loop_check:
    mov r10, byte [rbx]              ; загружаем байт по указателю из поля поиска
    mov r11, byte [r12]              ; загружаем байт по указателю искомой строки

; r10 равняется нулю если строка поиска закончилась и совпадений нет
    cmp r10, 0
    jz  return_value_not

; r11 равняется нулю если вся строка прошла проверку 
    cmp r11, 0
    jz  return_value_ok

    add rcx, 1                       ; инкрементирование счетчика
    cmp r10, r12                     ; сравнение элементов строк
    jnz loop_increment               ; если неравны
                                     ; если элементы равны 
    add rbx, rcx                     ; сдвигаем адрес в строке поиска
    add r12, rcx                     ; сдвигаем адрес в искомой строке

loop_increment
    add rbx, rcx                     ; сдвигаем адрес в строке поиска
    mov r12, rdx                     ; возвращаем к исходному значению

    jmp loop_check                   ; возврат к началу цикла

return_value_ok:   
    mov rax, [ rbx - r9]             ; текущее значение rbx минус длина искомой строки
    jmp return

return_value_not:
    mov rax, 0

return:

    pop r12
    pop r11
    pop r10
    pop r9

    ret