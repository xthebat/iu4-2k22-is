        section .text

        global task02_checksum
; u64 checksum(u8 *data<rdi>, u64 size<rsi>);
task02_checksum:
        push rbp
        
        mov rbp, rsp
        sub rsp, 8          ; u8 rsp[8] (cache);
        
        mov qword [rsp], 0x0  ; clear cache
        xor r8, r8              ; clear result
        xor rcx, rcx            ; clear i

    task02_checksum_loop_start:
        cmp rcx, rsi
        jae task02_checksum_loop_finish
        lea r11, [rcx + 8]      ; (заканчивается посередине и становится неприятно)
        cmp r11, rsi
        ja task02_checksum_loop_finish

    task02_checksum_loop_body:
        mov r10, qword [rdi + rcx]   ; r10 is used as temporary storage
        xor r8, r10

    task02_checksum_loop_end:
        add rcx, 8
        jmp task02_checksum_loop_start

    task02_checksum_loop_finish:
        mov rax, rsi
        mov r10, 8
        xor rdx, rdx
        ; ох ё
        ; rax задает целую часть, rdx задает дробную
        ; а после расчета результаты будут в регистрах:
        ; rdx = rax % r10
        ; rax = rax / r10
        div r10
        ; ok rdx now is loop_finish
        mov r9, rsi
        sub r9, rdx     ; r9 is base

        xor rcx, rcx

    task02_checksum_memloop_start:
        cmp rcx, rdx
        jae task02_checksum_memloop_finish
    
    task02_checksum_memloop_body:
        lea r10, [r9 + rcx]
        mov r10b, byte [rdi + r10]
        mov byte [rsp + rcx], r10b
    
    task02_checksum_memloop_end:
        inc rcx
        jmp task02_checksum_memloop_start

    task02_checksum_memloop_finish:
        mov r10, qword [rsp]
        xor r8, r10

    task02_checksum_end:
        mov rax, r8
        add rsp, 8

        pop rbp
        ret
