section .data
    long_string times 1024 db "A"
    result times 1024 db 0
    newline db 0xA

section .text
    global main

main:
    push rbp
    mov rbp, rsp

    mov rsi, long_string
    mov rdi, result
    mov rcx, 1024 / 16

.process_16_bytes:
    mov eax, [rsi]
    mov ebx, [rsi+4]
    mov edx, [rsi+8]
    mov r8d, [rsi+12]

    or eax, 0x20202020
    or ebx, 0x20202020
    or edx, 0x20202020  
    or r8d, 0x20202020

    mov [rdi], eax
    mov [rdi+4], ebx
    mov [rdi+8], edx
    mov [rdi+12], r8d

    add rsi, 16
    add rdi, 16
    loop .process_16_bytes

    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 1024
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall