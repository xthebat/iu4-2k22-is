        section .text

        global task01_memset
task01_memset:
        push rbp
        push rbx        ; Loop counter
        push r12        ; Initial ptr
        push r13        ; Filling value
        push r14        ; Size

        mov r12, rdi    ; Save void*ptr
        mov r13d, esi   ; Save int value (interpreted as u8)
        mov r14, rdx    ; Save size_t size

    task01_memset_loop_init:
        xor rbx, rbx

    task01_memset_loop_begin:
        cmp rbx, r14        ; break if ctr == size
        jz task01_memset_loop_finish

    task01_memset_loop_body:
        lea rax, [r12 + rbx]
        mov byte [rax], r13b

    task01_memset_loop_end:
        add rbx, 1
        jmp task01_memset_loop_begin

    task01_memset_loop_finish:

    task01_memset_end:
        mov rax, r12    ; Function returns ptr

        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

        global task01_memcpy
task01_memcpy:
        push rbp
        push rbx        ; Loop counter
        push r12        ; Destination
        push r13        ; Source
        push r14        ; Size

        mov r12, rdi    ; Save void* dest
        mov r13, rsi    ; Save void* src
        mov r14, rdx    ; Save size_t size

    task01_memcpy_loop_init:
        xor rbx, rbx

    task01_memcpy_loop_begin:
        cmp rbx, r14
        jz task01_memcpy_loop_finish

    task01_memcpy_loop_body:
        mov cl, byte [r13 + rbx]
        lea rax, [r12 + rbx]
        mov byte [rax], cl

    task01_memcpy_loop_end:
        add rbx, 1
        jmp task01_memcpy_loop_begin

    task01_memcpy_loop_finish:

    task01_memcpy_end:
        mov rax, r12    ; Function returns ptr

        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

        global task01_strlen
task01_strlen:
        push rbp
        push rbx        ; Loop counter
        push r12        ; Source string

        mov r12, rdi    ; Save const char* src

    task01_strlen_loop_init:
        xor rbx, rbx

    task01_strlen_loop_begin:
        mov al, byte [r12 + rbx]
        test al, al        ; break if str[i] == 0
        jz task01_strlen_loop_finish

    task01_strlen_loop_body:
        ; Nothing here :) We are just counting the string length

    task01_strlen_loop_end:
        add rbx, 1
        jmp task01_strlen_loop_begin

    task01_strlen_loop_finish:

    task01_strlen_end:
        mov rax, rbx    ; Counter value is the string length

        pop r12
        pop rbx
        pop rbp
        ret
