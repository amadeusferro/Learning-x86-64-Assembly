section .data
    align 32
    string1 times 128 db 'A'
    string2 times 128 db 'X'
    result times 128 db 0

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rsi, string1
    mov rdi, string2
    mov rdx, result
    mov rcx, 128/32

.process_avx:
    vmovdqu ymm0, [rsi]
    vmovdqu ymm1, [rdi]

    vpor ymm2, ymm0, ymm1

    vmovdqu [rdx], ymm2

    add rsi, 32
    add rdi, 32
    add rdx, 32
    dec rcx
    jnz .process_avx

    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 128
    syscall

    vzeroupper
    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall