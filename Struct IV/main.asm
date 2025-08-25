%define Point_x     0
%define Point_y     4
%define Point_size  8

section .data

    num_points equ 3
    points:
        dd 10, 20
        dd 30, 40
        dd 50, 60
    
    fmt_point db "Point %d: (%d, %d)", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rbx, 0
    mov r12, points

.print_loop:
    cmp rbx, num_points
    jge .end_loop

    mov rax, Point_size
    mul rbx
    lea r13, [r12 + rax]

    mov rdi, fmt_point
    mov rsi, rbx
    mov edx, [r13 + Point_x]
    mov ecx, [r13 + Point_y]
    xor eax, eax
    call printf

    inc rbx
    jmp .print_loop

.end_loop:
    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall