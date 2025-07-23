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




    mov esp, ebp
    pop ebp
    ret