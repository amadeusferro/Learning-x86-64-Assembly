section .data
    align 64
    source times 4096 db 'a'
    dest times 4096 db 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, source
    mov rdi, dest
    mov rcx, 4096 / 64

.stream_copy:
    movntdqa xmm0, [rsi]
    movntdqa xmm1, [rsi+16]
    movntdqa xmm2, [rsi+32]
    movntdqa xmm3, [rsi+48]

    movntdq [rdi], xmm0
    movntdq [rdi+16], xmm1
    movntdq [rdi+32], xmm2
    movntdq [rdi+48], xmm3

    add rsi, 64
    add rdi, 64
    dec rcx
    jnz .stream_copy

    sfence

    mov rax, 1
    mov rdi, 1
    mov rsi, dest
    mov rdx, 4096
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall