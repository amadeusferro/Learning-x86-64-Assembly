section .text
    global _start

_start:

    mov rax, 12
    xor rdi, rdi
    syscall

    mov r15, rax
    mov rbx, rax
    add rbx, 4

    mov rax, 12
    mov rdi, rbx
    syscall

    cmp rax, rbx
    jne .alloc_fail

    mov dword [r15], 10

    mov rax, 12
    mov rdi, r15
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

    .alloc_fail:
        mov rax, 60
        mov rdi, 1
        syscall