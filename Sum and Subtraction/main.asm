section .data
    num1    dd 10
    num2    dd 5
    sum     dd 0
    diff    dd 0

section .text
    global _start


_exit:
    mov eax, 1
    mov ebx, 0
    int 0x80


_start:
    mov eax, [num1]
    add eax, [num2]
    mov [sum], eax

    mov eax, [num1]
    sub eax, [num2]
    mov [diff], eax

    call _exit