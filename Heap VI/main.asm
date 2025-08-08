section .data
    msg db "Block resized using mremap!", 0xA, 0
    msg_len equ $ - msg
    newline db 0xA

section .text
    global _start

_start:

    mov rax, 9
    xor rdi, rdi
    mov rsi, 4096
    mov rdx, 3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    mov r15, rax

    mov rax, 25
    mov rdi, r15
    mov rsi, 4096
    mov rdx, 8192
    mov r10, 0
    xor r9, r9
    syscall

    mov r15, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rcx, 8192
    mov rdi, r15
    mov al, 'A'
    rep stosb

    mov rax, 1
    mov rdi, 1
    mov rsi, r15
    mov rdx, 8192
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall


    mov rax, 11
    mov rdi, r15
    mov rsi, 8192
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall