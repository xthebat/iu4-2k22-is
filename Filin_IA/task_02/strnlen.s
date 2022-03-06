; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax
; function strnlen ( const char *s, size_t maxlen )

strnlen:
    push rbx
    push r14
    mov rbx, rcx            ; запись в базовый регистр
    mov r14, rdx
    xor rcx, rcx            ; зануление счетчика

loop_strnlen:
    mov al, byte [rbx]      ; выгрузка байта

    add rbx, 1              ; инкрементирование адреса элемента строки 

    cmp rcx, r14            ; сравнение с заданным значением счетчика 
    jz  return_value        ; при равенстве значений переход по метке

    add rcx, 1              ; инкрементирование счетчика

    test al, al             ; проверка на нуль-символ
    jnz loop_strnlen 

return_value:

    mov rax, rcx            ; запись в регистр return

    pop r14                 ; выгрузка из стека
    pop rbx                 ; выгрузка из стека
    ret