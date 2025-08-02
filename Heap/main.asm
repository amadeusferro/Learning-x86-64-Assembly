section .data
    msg db "Allocating 1024 bytes on heap!", 0xA
    len equ $ - msg

section .text
    global _start

_start:
    mov rax, 12
    xor rdi, rdi
    syscall

    mov r15, rax

    mov rax, 12
    mov rdi, r15
    add rdi, 1024
    syscall

    cmp rax, r15
    jle alloc_error

    mov rdi, r15
    mov rcx, 1024
    mov al, 'A'
    rep stosb

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    mov rax, 12
    mov rdi, r15
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

alloc_error:
    mov rax, 60
    mov rdi, 1
    syscall