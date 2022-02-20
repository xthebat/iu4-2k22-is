    ; libc
    extern printf
    
    ; main.o
    extern task01_memset
    extern task01_memcpy
    extern task01_strlen
    
    section .text
    
test_memset_1:
        push rbp

        mov rbp, rsp
        sub rsp, 0x20
        
        mov rdi, rsp
        mov rsi, 'a'
        mov rdx, 0x17
        call task01_memset

        mov byte [rsp + 0x18], 0x00
    
        mov rdi, g_result_out
        mov rsi, rsp
        call printf

        add rsp, 0x20
        pop rbp
        ret
    
test_memcpy_1:
        push rbp

        mov rbp, rsp
        sub rsp, 0x20
        
        mov rdi, rsp
        mov rsi, g_str1_to_cpy
        mov rdx, 0x20
        call task01_memcpy
    
        mov rdi, g_result_out
        mov rsi, rsp
        call printf
        
        mov rdi, rsp
        mov rsi, g_str2_to_cpy
        mov rdx, 0x20
        call task01_memcpy
    
        mov rdi, g_result_out
        mov rsi, rsp
        call printf

        add rsp, 0x20
        pop rbp
        ret
    
test_strlen_1:
        push rbp

        mov rdi, g_str1_to_cpy
        call task01_strlen
    
        mov rdi, g_val_out
        mov rsi, rax
        call printf
        
        mov rdi, g_str2_to_cpy
        call task01_strlen
    
        mov rdi, g_val_out
        mov rsi, rax
        call printf

        pop rbp
        ret

    section .data

g_ptr_out:
    db "Ptr: %p",0x0A,0x00

g_val_out:
    db "Value: %lld",0x0A,0x00

g_result_out:
    db "Str: %s",0x0A,0x00

g_str1_to_cpy:
    db "MyAwesomeString",0x00
    align 0x10

g_str2_to_cpy:
    db "Only",0x1B,"[36mScience",0x1B,"[0m",0x00
    align 0x10

g_test_memset_1_name:
    db "Simple memset test",0x00

g_test_memcpy_1_name:
    db "Simple memcpy test",0x00

g_test_strlen_1_name:
    db "Simple strlen test",0x00

    global g_test_array
g_test_array:
    dq g_test_memset_1_name
    dq test_memset_1
    dq g_test_memcpy_1_name
    dq test_memcpy_1
    dq g_test_strlen_1_name
    dq test_strlen_1
    dq 0
