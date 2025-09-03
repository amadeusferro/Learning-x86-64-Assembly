section .data
    src db "Source string", 0
    dest times 32 db 0
    fmt db "%s", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, src
    mov rdi, dest
    cld

.copy_loop:
    lodsb
    stosb
    test al, al
    jnz .copy_loop

    mov rdi, fmt
    mov rsi, dest
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall