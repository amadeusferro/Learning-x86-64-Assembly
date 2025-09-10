section .data
    mixed_str db "Mixed Case String", 0
    len equ $ - mixed_str - 1
    fmt db "%s", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, mixed_str
    mov rcx, len

.to_upper:
    mov al, [rsi]
    cmp al, 'a'
    jb .next
    cmp al, 'z'
    ja .next

    sub byte [rsi], 0x20

.next:
    inc rsi
    loop .to_upper

    mov rdi, fmt
    mov rsi, mixed_str
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall