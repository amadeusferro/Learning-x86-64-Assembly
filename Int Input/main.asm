section .data
    num     dd -1

section .bss
    buffer resb 12


section .text
    global _start

print_num:
    mov byte [buffer], '+'
    mov ecx, 10
    mov edi, buffer + 11
    mov byte [edi], 0

    test eax, eax
    jz .zero
    js  .negative

.convert:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi 
    mov byte [edi], dl
    test eax, eax
    jnz .convert

    cmp byte [buffer], '-'
    jne .print
    dec edi
    mov byte [edi], '-'

.print:
    mov esi, buffer + 11
    sub esi, edi

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, esi
    int 0x80
    ret

.zero:
    dec edi
    mov byte [edi], '0'
    jmp .print

.negative:
    neg eax
    mov byte [buffer], '-'
    jmp .convert

_start:

    mov eax, -111
    call print_num

    mov eax, 0
    call print_num

    mov eax, 222
    call print_num





    mov eax, 1
    mov ebx, 0
    int 0x80