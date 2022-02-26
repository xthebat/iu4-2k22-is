        ; libc
        extern exit
        extern printf

        ; tests.o
        extern g_test_array
        
        section .text

hello:
        push rbp

        mov rbp, rsp
        mov rdi, g_msg
        call printf

        pop rbp
        ret

        global _start
_start:
        mov rbp, rsp
        call hello

    _start_test_loop_init:
        xor r13, r13             ; Counter

    _start_test_loop_begin:
        lea r12, [g_test_array+r13]      ; r12 is ArrayItem*
        mov rbx, [r12]
        test rbx, rbx
        jz _start_test_loop_finish

    _start_test_loop_body:
        mov rdi, g_test_info
        mov rsi, [r12]
        mov rdx, [r12+8]
        call printf

        mov rax, [r12+8]
        call rax

    _start_test_loop_end:
        add r13, 0x10
        jmp _start_test_loop_begin

    _start_test_loop_finish:
        xor rdi, rdi
        call exit

    _start_test_failed:
        mov rdi, 1
        call exit

        section .data

g_msg:
        db  0x1B,"[34mHello, task01!",0x1B,"[0m",0x0A, 0x00
g_test_info:
        db  0x0A,"Test name: ",0x1B,"[33m%s",0x1B,"[0m ptr: ",0x1B,"[34m%p",0x1B,"[0m",0x0A, 0x00
