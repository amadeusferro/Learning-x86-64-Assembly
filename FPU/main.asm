section .data
    float1  dd  1.5
    float2  dd  2.5
    result  dd  0.0

    sum     db  "Sum: "
    sum_len equ $ - sum
    subi     db  "Sub: "
    subi_len equ $ - subi
    mult    db  "Mult: "
    mult_len equ $ - mult
    divi    db  "Div: "
    divi_len equ $ - divi
    sqrt   db  "Sqrt: "
    sqrt_len equ $ - sqrt
    newline db  0xA

section .text
    global _start

print_float:
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 4
    int 0x80
    ret

_start:
    fld dword [float1]
    fld dword [float2]
    faddp
    fstp dword [result]

    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, sum_len
    int 0x80

    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; -----------------

    fld dword [float1]
    fld dword [float2]
    fsubp
    fstp dword [result]

    mov eax, 4
    mov ebx, 1
    mov ecx, subi
    mov edx, subi_len
    int 0x80

    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; -----------------

    fld dword [float1]
    fld dword [float2]
    fmulp
    fstp dword [result]

    mov eax, 4
    mov ebx, 1
    mov ecx, mult
    mov edx, mult_len
    int 0x80

    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; -----------------

    fld dword [float1]
    fld dword [float2]
    fdivp
    fstp dword [result]

    mov eax, 4
    mov ebx, 1
    mov ecx, divi
    mov edx, divi_len
    int 0x80

    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; -----------------

    fld dword [float1]
    fsqrt
    fstp dword [result]

    mov eax, 4
    mov ebx, 1
    mov ecx, sqrt
    mov edx, sqrt_len
    int 0x80

    call print_float

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; -----------------

    mov eax, 1
    mov ebx, 0
    int 0x80
