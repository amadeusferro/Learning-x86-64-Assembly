section .text
    global _start

_start:
    push dword 0
    push dword 0

    mov dword [esp], 123
    mov dword [esp+4], 456

    mov eax, [esp]
    mov ebx, [esp+4]
    add ebx, eax

    pop eax
    pop eax

    mov eax, 1
    mov ebx, 0
    int 0x80