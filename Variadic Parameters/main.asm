section .data
    fmt db "Numbers:  %d, %x, %f", 10, 0
    num_int dd 42
    num_float dd 3.1415

section .text
    global _start

_start:
    push dword [num_float]
    push 0xDEADBEEF
    push dword [num_in]
    push fmt
    call my_prinf
    add esp, 16

    mov eax, 1
    mov ebx, 0
    int 0x80

my_prinf:
    push ebp
    mov ebp, esp

    ; ebp+8  = format
    ; ebp+12 = first variadic param
    ; ebp+16 = second variadic param
    ; ...

    mov esi, [ebp+8]
    mov edi, 12

.process_fmt:
    lodsb
    cmp al, 0
    je .end

    cmp al, '%'
    jne .print_chat

    lodsb
    cmp al, 'd'
    je .print_int
    cmp al, 'x'
    je .print_hex
    ; ... others

.print_int:
    mov eax, [ebp+edi]
    add edi, 4
    ; print int
    jmp .process_fmt

.print_hex:
    mov eax, [ebp+edi]
    add edi, 4
    ; print hex
    jmp .process_fmt

.print_char:
    ; normal print
    jmp .process_fmt

.end:
    mov esp, ebp
    pop ebp
    ret