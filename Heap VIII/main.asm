section .data
    shm_msg db "Shared memory accessed!", 0xA, 0
    shm_len equ $ - shm_msg
    error_msg db "ERROR!", 0xA, 0
    error_len equ $ - error_msg

section .text
    global _start

_start:
    mov rax, 29 
    mov rdi, 1234
    mov rsi, 4096
    mov rdx, 0o666 | 0o1000
    syscall

    cmp rax, -1
    jle error_exit
    mov r15, rax

    mov rax, 30  
    mov rdi, r15
    xor rsi, rsi 
    xor rdx, rdx  
    syscall

    cmp rax, -1
    jle error_exit
    mov r14, rax  

    mov byte [r14], 'A'
    mov byte [r14+1], 0xA

    mov rax, 1   
    mov rdi, 1 
    mov rsi, shm_msg
    mov rdx, shm_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, r14
    mov rdx, 2
    syscall

    mov rax, 67
    mov rdi, r14
    syscall

    mov rax, 31
    mov rdi, r15
    mov rsi, 0  
    xor rdx, rdx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

error_exit:
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, error_len
    syscall

    mov rax, 60
    mov rdi, 1
    syscall