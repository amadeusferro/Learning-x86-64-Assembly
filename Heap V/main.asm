section .data
    alloc_msg db "Simple allocator in ASM", 0xA, 0
    alloc_msg_len equ $ - alloc_msg
    newline db 0xA

section .bss
    heap_start resq 1  

section .text
    global _start

my_malloc:
    push rbp
    mov rbp, rsp



.error:
    xor rax, rax   

.done:
    leave
    ret

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, alloc_msg
    mov rdx, alloc_msg_len
    syscall

    mov rdi, 64
    call my_malloc
    test rax, rax
    jz exit_error

    mov r15, rax

    mov rdi, r15
    mov rcx, 64
    mov al, 'A'
    rep stosb

    mov rax, 1
    mov rdi, 1
    mov rsi, r15
    mov rdx, 16
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

exit_error:
    mov rax, 60
    mov rdi, 1
    syscall