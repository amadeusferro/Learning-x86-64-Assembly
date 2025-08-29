%define Car_speed           0
%define Car_accelerate      8
%define Car_size            16

section .data
    fmt_speed db "Current speed: %d km/h", 0xA, 0

section .text
    global main
    extern printf

car_accelerate:
    push rbp
    mov rbp, rsp

    add dword [rdi + Car_speed], 10

    mov rsp, rbp
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp

    sub rsp, Car_size

    mov dword [rsp + Car_speed], 0
    lea rax, [car_accelerate]
    mov [rsp + Car_accelerate], rax

    lea rdi, [rsp]
    call [rsp + Car_accelerate]

    lea rdi, [rsp]
    call [rsp + Car_accelerate]

    lea rdi, [rsp]
    call [rsp + Car_accelerate]

    lea rdi, [rsp]
    call [rsp + Car_accelerate]

    mov rdi, fmt_speed
    mov esi, [rsp + Car_speed]
    xor rax, rax
    call printf

    add rsp, Car_size

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall