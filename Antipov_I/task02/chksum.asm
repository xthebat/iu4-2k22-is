SECTION .text
;int chksum(uint8_t* buf, int size)
chksum:
    ; push    r8
    xor     rax, rax
chksum_loop:
    test    rdx, rdx
    jz      chksum_ret
    movzx   r8, byte [rcx]
    add     rax, r8
    add     rcx, 1
    sub     rdx, 1
    jmp     chksum_loop

chksum_ret:
    ; pop     r8
    ret

