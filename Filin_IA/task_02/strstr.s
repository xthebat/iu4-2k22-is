; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax
; function strstr ( const char * string1, const char * string2 )

strstr:

    push r12
    push rbx

    mov r12, rdx
    mov rbx, rcx
    mov r8, rdx
    xor r9, r9                      ; зануление счетчика длины строки
    xor rcx, rcx                    ; зануление счетчика

loop_lenght_search:

    mov al, [r8]
    add r8, 1
    add r9, 1

    test al, al
    jnz loop_lenght_search

    sub r9, 1                       ; выкидываем нуль-символ
; r9 хранит в себе длину строки, которая должна входить в поле поиска

loop_check:

    mov r10b, byte [rbx]              ; загружаем байт по указателю из поля поиска
    mov r11b, byte [r12]              ; загружаем байт по указателю искомой строки

; r10 равняется нулю если строка поиска закончилась и совпадений нет
    cmp r10b, 0
    jz  return_value_not

; если счетчик rcx равняется длине строки, то поиск завершен успешно
    cmp r9, rcx
    jz  return_value_ok

    cmp r10b, r11b                   ; сравнение элементов строк
    jnz loop_increment               ; если неравны
                
                                     ; если элементы равны
    add rbx, 1                       ; сдвигаем адрес в строке поиска
    add r12, 1                       ; сдвигаем адрес в искомой строке        
    add rcx, 1

    jmp loop_check                   ; переход к началу цикла

loop_increment
    add rbx, 1                       ; сдвигаем адрес в строке поиска
    mov r12, rdx                     ; возвращаем к исходному значению
    mov rcx, 0                       ; обнуление счетчика совпадений
    jmp loop_check                   ; возврат к началу цикла

return_value_ok:

    mov rax, rbx           ; текущее значение rbx минус длина искомой строки
    sub rax, r9 

    jmp return

return_value_not:
    mov rax, 0

return:

    pop rbx
    pop r12

    ret