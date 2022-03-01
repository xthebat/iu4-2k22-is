    section .text

        global task02_strnlen
; u64 strnlen(const char *src<rdi>, u64 max_size<rsi>)
task02_strnlen:
    task02_strnlen_loop_init:
        xor rcx, rcx

    task02_strnlen_loop_begin:
        mov al, byte [rdi + rcx]
        test al, al        ; break if str[i] == 0
        jz task02_strnlen_loop_finish
        cmp rsi, rcx
        jbe task02_strnlen_loop_finish

    task02_strnlen_loop_body:
        ; Nothing here :) We are just counting the string length

    task02_strnlen_loop_end:
        add rcx, 1
        jmp task02_strnlen_loop_begin

    task02_strnlen_loop_finish:

    task02_strnlen_end:
        mov rax, rcx
        ret


        global task02_strncpy
; char *strncpy(char *dest<rdi>, const char *src<rsi>, u64 max_size<rdx>)
; if max_size > len(src) -- fill zeroes (whaaat)
task02_strncpy:
    task02_strncpy_loop_init:
        xor rcx, rcx

    task02_strncpy_loop_begin:
        cmp rdx, rcx
        jbe task02_strncpy_loop_finish

    task02_strncpy_loop_body:
        mov al, byte [rsi + rcx]
        test al, al
        jz task02_strncpy_fill_zero

    task02_strncpy_fill:
        ; Intel, can we have `mov [rdi + rcx], byte [rsi + rcx]` at home?
        ; - We already have this command at home.
        ; *This command at home:*
        mov byte [rdi + rcx], al
        jmp task02_strncpy_loop_end

    task02_strncpy_fill_zero:
        xor al, al
        jmp task02_strncpy_fill

    task02_strncpy_loop_end:
        add rcx, 1
        jmp task02_strncpy_loop_begin

    task02_strncpy_loop_finish:

    task02_strncpy_end:
        mov rax, rdi
        ret
