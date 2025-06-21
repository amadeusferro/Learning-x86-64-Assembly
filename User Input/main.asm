section .data
    msg1     db "Prompt a String: "
    msg1_len equ $ - msg1

section .bss
    buffer resb 50
    lenth  resd 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 100
    int 0x80

    mov [lenth], ecx

    ; TODO: Add null terminator

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, [lenth]
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80