section .data
    result db 0
    newline db 0xA

section .text
    global _start

sum_and_div:
    push ebp
    mov ebp, esp

    ; [ebp + 8]  = divisor (2)
    ; [ebp + 12] = num2    (3)
    ; [ebp + 16] = num1    (5)

    mov eax, [ebp + 16]
    add eax, [ebp + 12]

    push eax
    push dword [ebp + 8]
    call divide

    mov esp, ebp
    pop ebp
    ret

divide:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]
    cdq                
    div dword [ebp + 8]

    mov esp, ebp
    pop ebp
    ret

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

sum:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12]
    add eax, [ebp + 8]


    mov esp, ebp
    pop ebp
    ret

sum_and_divide:
    push ebp
    mov ebp, esp

    push dword [ebp + 16]
    push dword [ebp + 12]
    call sum

    push eax
    push dword [ebp + 8]
    call divide


    mov esp, ebp
    pop ebp
    ret

_start:
    push 5
    push 3
    push 2
    call sum_and_div
    sub esp, 12

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 2
    push 2
    push 2
    call sum_and_div
    sub esp, 12

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 10
    push 2
    call divide
    sub esp, 8

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 3
    push 2
    call sum
    sub esp, 8

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 1
    push 8
    call sum
    sub esp, 8

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 3
    push 3
    push 2
    call sum_and_divide
    sub esp, 12

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    push 5
    push 5
    push 2
    call sum_and_divide
    sub esp, 12

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    call print_newline

    ; -------------------------------------

    mov eax, 1
    mov ebx, 0
    int 0x80