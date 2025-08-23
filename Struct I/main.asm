%define person_id      0
%define person_name    8
%define person_age     60
%define person_height  64
%define person_size    72

section .data
    person_instance:
        dq 0                    ; id
        times 52 db 0           ; name
        dd 0                    ; age
        dd 0                    ; padding 
        dq 0.0                  ; height

    fmt db "ID: %d, Name: %s, Age: %d, Height: %.2f", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    mov dword [person_instance + person_id], 100
    mov byte [person_instance + person_name], 'J'
    mov byte [person_instance + person_name + 1], 'a'
    mov byte [person_instance + person_name + 2], 'm'
    mov byte [person_instance + person_name + 3], 'e'
    mov byte [person_instance + person_name + 4], 's'
    mov byte [person_instance + person_name + 5], 0
    mov dword [person_instance + person_age], 15
    mov qword [person_instance + person_height], __float64__(1.82)

    mov rdi, fmt
    mov esi, [person_instance + person_id]
    lea rdx, [person_instance + person_name]
    mov ecx, [person_instance + person_age]
    movsd xmm0, [person_instance + person_height]
    mov rax, 1
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall