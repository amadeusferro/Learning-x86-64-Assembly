section .data
    nums times 256 db 10
    fmt db "Soma total: %d", 10, 0

section .bss
    result resq 1

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov rcx, 256/8
    mov rsi, nums

.loop:
    mov rdx, [rsi]
    add rsi, 8

    mov rbx, rdx
    and rbx, 0x00FF00FF00FF00FF
    shr rdx, 8
    and rdx, 0x00FF00FF00FF00FF
    add rdx, rbx

    mov rbx, rdx
    and rbx, 0x0000FFFF0000FFFF
    shr rdx, 16
    and rdx, 0x0000FFFF0000FFFF
    add rdx, rbx

    mov rbx, rdx
    shr rdx, 32
    add rbx, rdx

    add rax, rbx

    loop .loop

    mov [result], rax

    mov rdi, fmt
    mov rsi, rax
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall