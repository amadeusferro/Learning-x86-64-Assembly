section .text
    global _start

_start:

    mov rax, 9
    xor rdi, rdi
    mov rsi, 0x100000
    mov rdx, 3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    mov r15, rax

    mov rax, 28
    mov rdi, r15
    mov rsi, 0x100000
    mov rdx, 1
    syscall

    mov rax, 11
    mov rdi, r15
    mov rsi, 0x100000
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall