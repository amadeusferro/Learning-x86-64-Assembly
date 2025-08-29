%define Vector_x        0
%define Vector_y        4
%define Vector_z        8
%define Vector_size     12

section .data
    fmt_vector db "Vector: (%.2f, %.2f, %.2f)", 10, 0
    vec1 dd 1.0, 2.0, 3.0
    scale_factor dd 2.0

section .text
    global main
    extern printf

scale_vector:
    push rbp
    mov rbp, rsp

    movss xmm0, [rdi + Vector_x]
    mulss xmm0, [scale_factor]
    movss [rdi + Vector_x], xmm0

    movss xmm0, [rdi + Vector_y]
    mulss xmm0, [scale_factor]
    movss [rdi + Vector_y], xmm0

    movss xmm0, [rdi + Vector_z]
    mulss xmm0, [scale_factor]
    movss [rdi + Vector_z], xmm0

    mov rsp, rbp
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp

    lea rdi, [vec1]
    call scale_vector

    mov rdi, fmt_vector
    movss xmm0, [vec1 + Vector_x]
    cvtss2sd xmm0, xmm0
    movss xmm1, [vec1 + Vector_y]
    cvtss2sd xmm1, xmm1
    movss xmm2, [vec1 + Vector_z]
    cvtss2sd xmm2, xmm2
    mov eax, 3
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall