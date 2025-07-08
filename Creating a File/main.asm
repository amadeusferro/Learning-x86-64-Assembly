O_WRONLY  equ 1
O_CREAT   equ 0100o
O_TRUNC   equ 01000o
S_IRUSR   equ 0400o
S_IWUSR   equ 0200o
S_IRGRP   equ 0040o
S_IROTH   equ 0004o

section .data
    msg db "Hello, world!"
    msg_len equ $ - msg
    filename db "HelloWorld.txt", 0
    success db "File created successfully", 0xA
    success_len equ $ - success
    fail db "Fail to create the file", 0xA
    fail_len equ $ - fail

section .text
    global _start

_start:

    mov eax, 5
    mov ebx, filename
    mov ecx, O_CREAT | O_WRONLY | O_TRUNC
    mov edx, 0644o ; permissions (rw-r--r--)
    int 0x80

    cmp eax, 0
    js .error_exit

    mov ebx, eax

    mov eax, 4
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    cmp eax, 0
    js .error_exit

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

.error_exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, fail
    mov edx, fail_len
    int 0x80

    mov eax, 1
    mov ebx, 1
    int 0x80