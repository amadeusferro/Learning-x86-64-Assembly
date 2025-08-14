section .text
    global _start

_start:
    mov rax, 9
    xor rdi, rdi
    mov rsi, 400
    mov rdx, 0x3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    mov r15, rax
    mov r14, 0

.loop_init:
    mov dword [r15 + r14+4], 100

    inc r14
    cmp r14, 100
    jl .loop_init

    mov rax, 11
    mov rdi, r15
    mov rsi, 400
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall