section .data
    result db 0

section .text
    global _start

sum:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    add eax, [ebp + 12]

    mov esp, ebp
    pop ebp
    ret

_start:
    push 5
    push 1
    call sum
    sub esp, 8

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    nl db 10
