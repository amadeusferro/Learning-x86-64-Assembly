section .data
    nums db 1, 2, 3, 4, 5, 6, 8
    msg db "Sum: %d", 0xA, 0

section .bss
    res resq 1

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rax, [nums]

    mov rbx, rax
    and rbx, 0x00FF00FF00FF00FF
    shr rax, 8
    and rax, 0x00FF00FF00FF00FF
    add rax, rbx

    mov rbx, rax
    and rbx, 0x0000FFFF0000FFFF
    shr rax, 16
    and rax, 0x0000FFFF0000FFFF
    add rax, rbx 

    mov rbx, rax
    shr rbx, 32
    add eax, ebx

    mov [res], rax

    mov rdi, msg
    mov rsi, rax
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall
