%define Shape_vtable 0
%define Shape_x      8
%define Shape_y      12
%define Shape_size   16

%define VTable_draw  0
%define VTable_area 8


section .data

    fmt_draw db "Drawing at (%d, %d)", 10, 0
    fmt_area db "Area: %d", 10, 0
    mmap_error_msg: db "Error during memory map", 0xA, 0

section .text
    global main
    extern printf

circle_draw:
    push rbp
    mov rbp, rsp
    
    push rsi
    
    mov rdi, fmt_draw
    mov esi, [rsi + Shape_x]
    mov edx, [rsp + 8 + Shape_y]
    xor eax, eax
    call printf
    
    pop rsi

    mov rsp, rbp
    pop rbp
    ret

circle_area:
    push rbp
    mov rbp, rsp

    mov rdi, fmt_area
    mov esi, 100
    xor eax, eax
    call printf

    mov rsp, rbp
    pop rbp
    ret

circle_vtable:
    dq circle_draw
    dq circle_area

main:
    push rbp
    mov rbp, rsp

    mov rax, 9 
    xor rdi, rdi
    mov rsi, Shape_size 
    mov rdx, 0x3  
    mov r10, 0x22 
    mov r8, -1 
    xor r9, r9 
    syscall

    cmp rax, -1
    je .mmap_error
    mov r12, rax

    lea rax, [circle_vtable]
    mov [r12 + Shape_vtable], rax
    mov dword [r12 + Shape_x], 10
    mov dword [r12 + Shape_y], 20


    mov rsi, r12
    mov rax, [r12 + Shape_vtable]
    call [rax + VTable_draw]

    mov rsi, r12
    mov rax, [r12 + Shape_vtable]
    call [rax + VTable_area]  


    mov rax, 11   
    mov rdi, r12  
    mov rsi, Shape_size 
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

.mmap_error:
    mov rdi, mmap_error_msg
    call printf

    mov rax, 60
    mov rdi, 1
    syscall