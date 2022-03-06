
; calling cinvention x86 OS Windows
; argument's: rcx, rdx, r8, r9
; return : rax

; FUNCTION
;int chksum(uint8_t* buf, int size) {
;    int result = 0;
;    for (int k = 0; k < size; k++) {
;        result += buf[k];
;    }
;    return result;
;}

chksum:
    push rbx                ; выгрузка в стек

    mov rbx, rcx            ; запись в базовый регистр
    xor rcx, rcx            ; обнуление rcx для последующей его работы как счетчика
    xor r9, r9              ; а вдруг там, что-то лежало 

loop_chksum:

    mov al, byte [rbx]      ; загрузка одного байта из источника
    add rbx, 1              ; двигаем адрес
    add r9, al              ; прибавляем элемент массива

    cmp rcx, rdx            ; сравнение счетчика с количеством элементов массива
    jz return_result

    add rcx, 1              ; инкрементирование счетчика

    jmp loop_chksum

return_result:

    mov eax, r9

    pop rbx 
    ret

