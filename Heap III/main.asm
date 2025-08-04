section .data
    success_msg db "Memory allocated successfuly!", 0xA, 0
    success_len equ $ - success_msg
    failed_msg db "Failed to alocate memory!", 0xA, 0
    failed_len equ $ - failed_msg

section .text
    global _start

_start:

    mov rax, 0x9
    xor rdi, rdi
    mov rsi, 4096
    mov rdx, 0x3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    cmp rax, -1
    je .error

    mov r15, rax

    mov rdi, r15
    mov rax, 0x6F6C6C6548
    mov [rdi], rax
    mov byte [rdi+5], 0x0A

    mov rax, 1
    mov rdi, 1
    mov rsi, r15
    mov rdx, 6
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, success_msg
    mov rdx, success_len
    syscall

    mov rax, 11
    mov rdi, r15
    mov rsi, 4096
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

.error:
    mov rax, 1
    mov rdi, 1
    mov rsi, failed_msg
    mov rdx, failed_len
    syscall

    mov rax, 60
    mov rdi, 1
    syscall