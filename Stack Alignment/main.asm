section .data
    msg db "Stack aligned!", 10, 0

section .text
    global _start

print:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 15
    syscall
    ret

_start:
    push rbx

    sub rsp, 8

    mov rdi, msg
    call print

    add rsp, 8
    pop rbx

    mov rax, 60
    xor rdi, rdi
    syscall