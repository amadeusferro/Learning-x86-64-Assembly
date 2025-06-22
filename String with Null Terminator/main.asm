section .data
    msg     db "Write a text: "
    msg_len equ $ - msg

section .bss
    buffer resb   50
    length resd   1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 100
    int 0x80

    mov [length], eax
    mov esi, buffer
    add esi, [length]
    dec esi
    mov byte [esi], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, [length]
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80