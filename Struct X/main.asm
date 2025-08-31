%define Animal_vtable 0
%define Animal_age    8
%define Animal_size   16

%define Dog_base      0
%define Dog_breed     16
%define Dog_size      24

%define VTable_speak  0

section .data
    fmt_woof db "Woof! I'm %d years old. Breed: %s", 10, 0
    breed_str db "Golden Retriever", 0
    mmap_error_msg: db "Error during memory map", 0xA, 0

section .text
    global main
    extern printf

dog_speak:
    push rbx
    mov rbx, rsi
    mov rdi, fmt_woof
    mov eax, [rbx + Animal_age]
    mov esi, eax
    mov rdx, [rbx + Dog_breed] 
    xor rax, rax 
    call printf
    pop rbx
    ret

dog_vtable:
    dq dog_speak

main:
    push rbp
    mov rbp, rsp

    mov rax, 9 
    xor rdi, rdi
    mov rsi, Dog_size 
    mov rdx, 0x3  
    mov r10, 0x22 
    mov r8, -1 
    xor r9, r9 
    syscall

    cmp rax, -1
    je .mmap_error
    mov r12, rax

    lea rax, [dog_vtable]
    mov [r12 + Animal_vtable], rax
    mov dword [r12 + Animal_age], 5
    lea rax, [breed_str]
    mov [r12 + Dog_breed], rax

    mov rsi, r12
    mov rax, [r12 + Animal_vtable]
    call [rax + VTable_speak]

    mov rax, 11   
    mov rdi, r12  
    mov rsi, Dog_size 
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