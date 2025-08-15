section .text
    global _start

_start:

    mov rax 9,
    xor rdi, rdi
    mov rsi, 8
    mov rdx, 0x3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    mov r15, rax

    mov dword  [r15], 11
    mov dword [r15+4], 10

    mov rax, 11
    mov rdi, r15
    mov rsi, 8
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall