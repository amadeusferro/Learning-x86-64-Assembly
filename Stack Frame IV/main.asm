section .data
    array dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    size dd 10

section .bss
    total_array_sum resd 1

section .text
    global _start

sum_array:
    push ebp
    mov ebp, esp

    sub esp, 16

    ; Args:
    ; [ebp+8]  - pointer to array
    ; [ebp+12] - array size
    
    ; Lcal Variables:
    ; [ebp-4]  - sum (int)
    ; [ebp-8]  - counter i (int)
    ; [ebp-12] - temporary value

    mov dword [ebp-4], 0
    mov dword [ebp-8], 0

.loop:
    mov eax, [ebp-8]
    cmp eax, [ebp+12]
    jge .end_loop

    mov edx, [ebp+8]
    mov ecx, [ebp-8]
    mov eax, [edx + ecx*4]
    mov [ebp-12], eax

    add [ebp-4], eax
    inc dword [ebp-8]
    jmp .loop

.end_loop:
    mov eax, [ebp-4]
    mov esp, ebp
    pop ebp
    ret

_start:
    push dword [size]
    push dword array
    call sum_array
    add esp, 8

    mov dword [total_array_sum], eax

    mov eax, 1
    mov ebx, 0
    int 0x80