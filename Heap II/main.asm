section .data
    success_msg db "Memory allocated successfuly!", 0xA, 0
    success_len equ $ - success_msg
    failed_msg db "Failed to allocate memory!", 0xA, 0
    failed_len equ $ - failed_msg

section .text
    global _start

_start:

    mov rax, 12
    xor rdi, rdi
    syscall

    mov r15, rax

    mov rax, 12
    mov rdi, r15
    add rdi, 2048
    syscall

    cmp rax, r15
    jle .error

    mov rdi, r15
    mov rcx, 2048
    mov al, 'X'
    rep stosb

    mov rax, 1
    mov rdi, 1
    mov rsi, success_msg
    mov rdx, success_len
    syscall

    mov rax, 12
    mov rdi, r15
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

.error:
    mov rax, 1
    mov rdi, 1
    mov rsi, failed_len
    mov rdx, failed_len
    syscall

    mov rax, 60
    mov rdi, 1
    syscall