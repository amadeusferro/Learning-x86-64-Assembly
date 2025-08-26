%define Point_x     0
%define Point_y     4
%define Point_z     8
%define Point_size   12

section .data

    fmt_point db "Point %d: (%d, %d, %d)", 0xA, 0
    alloc_error_msg db "Error during memory alocation", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rax, 9
    xor rdi, rdi
    mov rsi, 12000
    mov rdx, 0x3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    cmp rax, -1
    je .alloc_error

    mov r15, rax
    xor rbx, rbx

.loop_start:
    cmp rbx, 1000
    jge .loop_end

    mov rax, rbx
    mov rcx, Point_size
    mul rcx

    lea r14, [r15 + rax]

    mov [r14 + Point_x], ebx
    mov [r14 + Point_y], ebx
    mov [r14 + Point_z], ebx

    inc rbx
    jmp .loop_start
.loop_end:

    xor rbx, rbx

.print_loop_start:
    cmp rbx, 1000
    jge .print_loop_end

    mov rax, rbx
    mov rcx, Point_size
    mul rcx 

    lea r14, [r15 + rax]

    mov rdi, fmt_point
    mov rsi, rbx
    mov edx, [r14 + Point_x]
    mov ecx, [r14 + Point_y]
    mov r8, [r14 + Point_y]
    xor eax, eax
    call printf

    inc rbx
    jmp .print_loop_start
.print_loop_end:

    mov rax, 11
    mov rdi, r15
    mov rsi, 12000
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

.alloc_error:
    mov rdi, alloc_error_msg
    call printf

    mov rax, 60
    mov rdi, 1
    syscall