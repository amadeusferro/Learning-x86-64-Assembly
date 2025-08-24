%define Book_title      0
%define Book_author     50
%define Book_pages      100
%define Book_price      104
%define Book_size       108

section .data

    fmt_book db "Title: %s, Author: %s, Pages: %d, Price: $%.2f", 0xA, 0
    title db "The Art of Assembly", 0
    author db "Randall Hyde", 0
    mmap_error_msg db "Error during mmap", 0xA, 0
    mmap_error_msg_len equ $ - mmap_error_msg

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rax, 9
    xor rdi, rdi
    mov rsi, Book_size
    mov rdx, 0x3
    mov r10, 0x22
    mov r8, -1
    xor r9, r9
    syscall

    cmp rax, -1
    je .mmap_error

    mov rbx, rax


    lea rsi, [title]
    lea rdi, [rbx + Book_title]
    mov rcx, 19
    rep movsb

    lea rsi, [author]
    lea rdi, [rbx + Book_author]
    mov rcx, 12
    rep movsb

    mov dword [rbx + Book_pages], 500

    mov eax, __float32__(29.99)
    mov dword [rbx + Book_price], eax

    
    mov rdi, fmt_book
    lea rsi, [rbx + Book_title]
    lea rdx, [rbx + Book_author]
    mov ecx, [rbx + Book_pages]
    movss xmm0, [rbx + Book_price]
    cvtss2sd xmm0, xmm0
    mov eax, 1
    call printf


    mov rax, 11
    mov rdi, rbx
    mov rsi, Book_size
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

.mmap_error:
    mov rax, 1
    mov rdi, 1
    mov rsi, mmap_error_msg
    mov rdx, mmap_error_msg_len
    syscall

    mov rax, 60
    mov rdi, 1
    syscall