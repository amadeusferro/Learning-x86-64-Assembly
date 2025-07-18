section .data
    array dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    array_size dd 10

section .bss
    total resd 1

section .text
    global _start

sum_array:
    push ebp
    mov ebp, esp

    sub esp, 16

    ; [ebp + 8] = array_ptr
    ; [ebp + 12] = array_size
    ; [ebp - 4] = i
    ; [ebp - 8] = sum
    ; [ebp - 12] = temp

    mov dword [ebp-4], 0
    mov dword [ebp-8], 0

.loop:
    mov eax, [ebp - 4]
    cmp eax, [ebp + 12]
    jge .loop_end

    mov edx, [ebp + 8]
    mov ecx, [ebp-4]
    mov eax, [edx + ecx*4]
    add  [ebp-8], eax

    inc dword [ebp-4]

    jmp .loop


.loop_end:
    mov eax, [ebp-8]

    mov esp, ebp
    pop ebp
    ret

_start:

    push dword [array_size]
    push dword array
    call sum_array
    add esp, 8

    mov [total], eax

    mov eax, 1
    mov ebx, 0
    int 0x80