section .data
    num1    dd  10
    num2    dd 2
    div_result dd 0
    mult_result dd 0
    mod_result  dd 0

    msg_div    db "Integer Division: "
    msg_div_len equ $ - msg_div
    msg_mult    db "Multiplication: "
    msg_mult_len equ $ - msg_mult
    msg_mod    db "Remainder: "
    msg_mod_len equ $ - msg_mod

    newline db 0xA

section .bss
    buffer resb 11

section .text
    global _start

print_number:
    mov ecx, 10
    mov edi, buffer + 10
    mov byte [edi], 0

    test eax, eax
    jnz .convert
    dec edi
    mov byte [edi], '0'
    jmp .print

    .convert:
        xor edx, edx
        div ecx
        add dl, '0'
        dec edi
        mov [edi], dl
        test eax, eax
        jnz .convert

    .print:
        mov esi, buffer + 10
        sub esi, edi

        mov eax, 4
        mov ebx, 1
        mov ecx, edi
        mov edx, esi
        int 0x80

        ret

_start:
    mov eax, [num1]
    mov ecx, [num2]
    mul ecx
    mov [mult_result], eax

    mov eax, [num1]
    mov ecx, [num2]
    xor edx, edx
    div ecx
    mov [div_result], eax
    mov [mod_result], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mult
    mov edx, msg_mult_len
    int 0x80

    mov eax, [mult_result]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_div
    mov edx, msg_div_len
    int 0x80

    mov eax, [div_result]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mod
    mov edx, msg_mod_len
    int 0x80

    mov eax, [mod_result]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
