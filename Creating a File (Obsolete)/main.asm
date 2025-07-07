section .data
    filename db "HelloWorld.txt", 0
    message db "Hello, world!"
    message_len equ $ - message
    success db "File created successfully!", 0xA
    success_len equ $ - success
    error db "Error created file!", 0xA
    error_len equ $ - error

section .text
    global _start

_start:
    mov eax, 8
    mov ebx, filename
    mov ecx, 0x1A4
    int 0x80

    cmp eax, 0
    jl .exit_error

    mov ebx, eax    ; file descriptor

    mov eax, 4
    mov ecx, message
    mov edx, message_len
    int 0x80

    cmp eax, 0
    jl .exit_error

    mov eax, 6
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, success
    mov edx, success_len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

    .exit_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, error_len
    int 0x80

    mov eax, 1
    mov ebx, 1
    int 0x80