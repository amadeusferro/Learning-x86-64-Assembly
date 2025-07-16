section .data
    a_msg db "A: ", 0
    a_msg_len equ $ - a_msg
    b_msg db "B: ", 0
    b_msg_len equ $ - b_msg
    newline db 0xA

    a dd 5
    b dd 7

section .bss
    char resb 1

section .text
    global _start

incremet_two:
    push ebp
    mov ebp, esp

    sub esp, 4

    mov dword [ebp - 4], 2

    mov eax, [ebp+8]
    add eax, [ebp - 4]
    mov edx, [ebp+12]
    add edx, [ebp - 4]

    mov esp, ebp
    pop ebp
    ret

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, a_msg
    mov edx, a_msg_len
    int 0x80

    mov eax, [a]
    add al, '0'
    mov [char], al

    mov eax, 4
    mov ebx, 1
    mov ecx, char
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, b_msg
    mov edx, b_msg_len
    int 0x80

    mov eax, [b]
    add al, '0'
    mov [char], al

    mov eax, 4
    mov ebx, 1
    mov ecx, char
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    push dword [b]
    push dword [a]
    call incremet_two
    add esp, 8

    mov [a], eax
    mov [b], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, a_msg
    mov edx, a_msg_len
    int 0x80
    
    mov eax, [a]
    add al, '0'
    mov [char], al

    mov eax, 4
    mov ebx, 1
    mov ecx, char
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, b_msg
    mov edx, b_msg_len
    int 0x80

    mov eax, [b]
    add al, '0'
    mov [char], al

    mov eax, 4
    mov ebx, 1
    mov ecx, char
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80