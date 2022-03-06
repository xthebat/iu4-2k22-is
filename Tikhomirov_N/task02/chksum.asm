;int chksum(uint8_t* buf, int size) {
;    int result = 0;
;    for (int k = 0; k < size; k++) {
;        result += buf[k];
;    }
;    return result;
;}

; rcx - array of bytes
; rdx - size


SECTION .text
chksum:
    xor eax, eax                      ; чистим регистр (best practice)
    chksum_cycle:
        test rdx, rdx                 ; критерий выхода из цикла
        jz chksum_finish
            movzx r8d, byte [rcx]     ; надо сложить x8 и x32, поэтому используем буфер ; movzx is awesome also
            add eax, r8d              ; (собсна выкладываем из буфера и делаем сложение)
            add rcx, 1                ; двигаем указатель
            sub rdx, 1                ; уменьшаем счётчик
            jmp chksum_cycle          ; цикл
    chksum_finish:
ret
; как говорил Жуков Алексей Евгеньевич, это задача для маленьких сопливых девочек
