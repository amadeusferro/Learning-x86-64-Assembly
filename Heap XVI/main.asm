section .data
    heap_start dq 0

section .text
    global _start

my_malloc:
    push rbp
    mov rbp, rsp

    cmp qword [heap_start], 0
    jne .alloc

    mov rax, 12
    xor rdi, rdi
    syscall
    mov [heap_start], rax

.alloc:

    add rdi, 15
    and rdi, -16

    mov rax, 12
    mov rbx, [heap_start]
    add rbx, rdi 
    mov rdi, rbx
    syscall

    cmp rax, rbx
    jne .alloc_fail

    mov rax, [heap_start]
    mov [heap_start], rbx
    
    leave

.fail:
    xor rax, rax
    leave

my_free:
    push rbp
    mov rbp, rsp
    ; 
    leave

_start:
    mov rdi, 4
    call my_malloc
    test rax, rax
    jz .alloc_fail

    mov r15, rax

    mov dword [r15], 10

    mov rdi, r15
    call my_free

    mov rax, 60
    xor rdi, rdi
    syscall

.alloc_fail:
    mov rax, 60
    mov rdi, 1
    syscall