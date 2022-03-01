    ; libc
    extern printf
    
    ; main.o
    extern task02_strnlen
    extern task02_strncpy
    extern task02_checksum
    
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

        sub rax, 0x3

        mov rdi, g_str_out
        mov rsi, rax
        call printf

        add rsp, 0x20
        pop rbp
        ret

test_checksum_1:
        push rbp

        mov rdi, 0
        mov rsi, 0
        call task02_checksum
        
        mov rdi, g_ptr_out
        mov rsi, rax
        call printf

        mov rdi, g_data_for_checksum
        mov rsi, 0x1C
        call task02_checksum
        
        mov rdi, g_ptr_out
        mov rsi, rax
        call printf

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

g_data_for_checksum:
                                ; 0x00
    dq 0x2591253EF1C88584       ; 0x08
    dq 0x9C1AB1154A25AAB5       ; 0x10
    dq 0x2FB61507D2ADBA07       ; 0x18
    dq 0x00000000BA76E463       ; 0x1C

    align 0x10

g_empty:
    db 0x00

g_test_strnlen_1_name:
    db "Simple strnlen test",0x00

g_test_strncpy_1_name:
    db "Simple strncpy test",0x00

g_test_checksum_1_name:
    db "Simple checksum test",0x00

    global g_test_array
g_test_array:
    dq g_test_strnlen_1_name
    dq test_strnlen_1
    dq g_test_strncpy_1_name
    dq test_strncpy_1
    dq g_test_checksum_1_name
    dq test_checksum_1
    dq 0
    dq 0
