section .text
    global _start

_start:
    sub esp, 16

    mov dword [esp], 42
    mov dword [esp + 4], 100

    add esp, 16

    mov eax, 1
    mov ebx, 0
    int 0x80