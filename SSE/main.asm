section .data
    num1    dd 5.0
    num2    dd 2.0
    result  dd 0.0

    newline db 0xA
    sum     db "Sum: "
    sum_len equ $ - sum
    subi     db "Sub: "
    subi_len equ $ - subi
    mult    db "Mult: "
    mult_len equ $ - mult
    divi    db "Divi: "
    divi_len equ $ - divi
    sqrt    db "Sqrt: "
    sqrt_len equ $ - sqrt

section .text
    global _start

print_float:

_start:
    movss xmm0, [num1]
    movss xmm1, [num2]
    addss xmm0, xmm1
    movss [result], xmm0

    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, sum_len
    int 0x80

    mov eax, [result]
    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----------------

    movss xmm0, [num1]
    subss xmm1, [num2]
    addss xmm0, xmm1
    movss [result], xmm0

    mov eax, 4
    mov ebx, 1
    mov ecx, subi
    mov edx, subi_len
    int 0x80

    mov eax, [result]
    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----------------

    movss xmm0, [num1]
    addss xmm1, [num2]
    addss xmm0, xmm1
    movss [result], xmm0

    mov eax, 4
    mov ebx, 1
    mov ecx, mult
    mov edx, mult_len
    int 0x80

    mov eax, [result]
    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----------------

    movss xmm0, [num1]
    divss xmm1, [num2]
    addss xmm0, xmm1
    movss [result], xmm0

    mov eax, 4
    mov ebx, 1
    mov ecx, divi
    mov edx, divi_len
    int 0x80

    mov eax, [result]
    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----------------

    movss xmm0, [num1]
    movss xmm1, [num2]
    sqrtss xmm0, xmm1
    movss [result], xmm0

    mov eax, 4
    mov ebx, 1
    mov ecx, sqrt
    mov edx, sqrt_len
    int 0x80

    mov eax, [result]
    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; ----------------

    mov eax, 1
    mov ebx, 0
    int 0x80