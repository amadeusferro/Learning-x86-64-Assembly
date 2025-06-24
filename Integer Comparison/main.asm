section .data
    greater_msg db  "EAX is greater than EBX"
    greater_msg_len equ $ - greater_msg
    equal_msg   db  "EAX is equal to EBX"
    equal_msg_len equ $ - equal_msg
    less_msg    db  "EAX is less than EBX"
    less_msg_len equ $ - less_msg
    none_msg    db  "None of the above"
    none_msg_len equ $ - none_msg
    newline     db 0xA

    num1    dd  1000
    num2    dd  1000

section .text
    global _start

compare:
    cmp eax, ebx

    jg .greater
    je .equal
    jl .less

    mov ecx, none_msg
    mov edx, none_msg_len
    jmp .print

    .greater:
        mov ecx, greater_msg
        mov edx, greater_msg_len
        jmp .print

    .equal:
        mov ecx, equal_msg
        mov edx, equal_msg_len
        jmp .print

    .less:
        mov ecx, less_msg
        mov edx, less_msg_len
        jmp .print

    .print:
        mov eax, 4
        mov ebx, 1
        int 0x80
        ret
_start:

    mov eax, [num1]
    mov ebx, [num2]
    call compare

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80