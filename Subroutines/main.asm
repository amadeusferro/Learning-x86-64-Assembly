section .data
    msg1    db "Hello, world!", 10
    len1    equ $ - msg1
    msg2    db "Assembly x86", 10
    len2    equ $ - msg2

section .text
    global _start


print:
    mov eax, 4
    mov ebx, 1
    int 80h
    ret

_start:
    mov ecx, msg1
    mov edx, len1
    call print

    mov ecx, msg2
    mov edx, len2
    call print

    mov eax, 1
    mov ebx, 0
    int 80h