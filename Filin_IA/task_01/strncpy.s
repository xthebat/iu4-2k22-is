; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax
; function strncpy ( char * destptr, const char * srcptr, size_t num )

strncpy:
    push rbx
    push r14
    mov rax, rcx            ; сохраняем указатель на строку назначения (он не изменится)
    mov rbx, rcx            ; запись в базовый регистр
    mov r14, rdx            
    xor rcx, rcx            ; зануление счетчика

loop_strncpy:
    mov al, byte [r14]      ; загрузка одного байта из источника
    add rcx, 1              ; инкрементирование счетчика
    add r14, rcx            ; переход к новому адресу источника

    cmp rcx, r8             ; сравнение с заданным значением счетчика
    jz  return_value        ; при равенстве значений переход по метке 

    test al, al             ; проверка на наличие нуль-символа
    jz  filling_zeros       ; при равенстве 0 переход по метке
                            ; если данные не равнются 0 и счетчик не переполнен
    str al, [rbx]           ; загрузка данных по адресу строки назначения
    add rbx, rcx            ; переход к новому адресу назначения
    jmp loop_strncpy        ; переход к началу функции

filling_zeros:              ; заполнение нулями оставшийся объем строки

    str 0, [rbx]            ; загрузка данных по адресу строки назначения
    add rbx, rcx            ; переход к новому адресу назначения
    jmp loop_strncpy        ; переход к началу функции       

return_value:

    pop r14                 ; выгрузка из стека
    pop rbx                 ; выгрузка из стека
    ret