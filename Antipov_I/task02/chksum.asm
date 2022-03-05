SECTION .text
;int chksum(uint8_t* buf, int size)
chksum:
    ; push    r8
    xor     rax, rax
chksum_loop:
    test    edx, edx
    jz      chksum_ret
    movzx   r8d, byte [rcx]
    add     eax, r8d
    add     rcx, 1
    sub     edx, 1
    jmp     chksum_loop

chksum_ret:
    ; pop     r8
    ret

