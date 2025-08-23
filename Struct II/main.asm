%define Person_id   0
%define Person_name 4
%define Person_age 54
%define Person_height 58
%define Person_size 62

section .data
    person1:
        dd 0                ; id
        times 50 db 0       ; name
        dd 0                ; age
        dd 0.0              ; height

    fmt_person db "ID: %d, Name: %s, Age: %d, Height: %.2f", 10, 0
    new_name db "John Douglas", 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov dword [person1 + Person_id], 1011
    mov dword [person1 + Person_age], 25

    lea rsi, [new_name]
    lea rdi, [person1 + Person_name]
    mov rcx, 12
    rep movsb

    mov eax, __float32__(1.68)
    mov [person1 + Person_height], eax

    mov rdi, fmt_person
    mov esi, [person1 + Person_id]
    lea rdx, [person1 + Person_name]
    mov ecx, [person1 + Person_age]
    movss xmm0, [person1 + Person_height]
    cvtss2sd xmm0, xmm0
    mov rax, 1
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall