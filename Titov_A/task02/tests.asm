    ; libc
    extern printf
    
    ; main.o
    extern task02_strnlen
    extern task02_strncpy
    
    section .text
    
test_strnlen_1:
        push rbp

        mov rdi, g_str1_to_cpy
        mov rsi, 0x100
        call task02_strnlen

        mov rdi, g_val_out
        mov rsi, rax
        call printf

        mov rdi, g_str1_to_cpy
        mov rsi, 0x08
        call task02_strnlen

        mov rdi, g_val_out
        mov rsi, rax
        call printf

        pop rbp
        ret

test_strncpy_1:
        push rbp
        mov rbp, rsp
        sub rsp, 0x20

        mov rdi, rsp
        mov rsi, g_str1_to_cpy
        mov rdx, 0x100
        call task02_strncpy
        
        mov byte [rsp + 0xF], 0x00

        mov rdi, g_str_out
        mov rsi, rax
        call printf

        lea rdi, [rsp + 0x3]
        lea rsi, [g_str1_to_cpy + 0x2]
        mov rdx, 0x3
        call task02_strncpy

        mov rdi, g_str_out
        mov rsi, rax
        call printf

        add rsp, 0x20
        pop rbp
        ret


    section .data

g_ptr_out:
    db "Ptr: %p",0x0A,0x00

g_val_out:
    db "Value: %lld",0x0A,0x00

g_str_out:
    db "Str: %s",0x0A,0x00

g_str1_to_cpy:
    db "MyAwesomeString",0x00
    align 0x10

g_str2_to_cpy:
    db "Only",0x1B,"[36mScience",0x1B,"[0m",0x00
    align 0x10
g_pattern_to_find:
    db "bbl",0x00

g_empty:
    db 0x00

g_test_strnlen_1_name:
    db "Simple strnlen test",0x00

g_test_strncpy_1_name:
    db "Simple strncpy test",0x00

    global g_test_array
g_test_array:
    dq g_test_strnlen_1_name
    dq test_strnlen_1
    dq g_test_strncpy_1_name
    dq test_strncpy_1
    dq 0
    dq 0
