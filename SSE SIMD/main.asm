section .data
    array1  dd 1.2, 3.4, 5.6, 7.8
    array2  dd 0.5, 1.0, 1.5, 2.0
    result  dd 0.0, 0.0, 0.0, 0.0

    array3  dq 1.2, 3.4
    array4  dq 0.5, 1.0
    result2  dq 0.0, 0.0

section .text
    global _start:

print_float_array:
    ret

_start:
    movaps xmm0, [array1]
    movaps xmm1, [array2]
    addps xmm0, xmm1
    movaps [result], xmm0

    mov eax, [result]
    call print_float_array

    mov eax, 4
    mov ebx, 1
    mov ecx, 0xA
    mov edx, 1
    int 0x80

    movapd xmm0, [array3]
    movapd xmm1, [array4]
    mulpd xmm0, xmm1
    movapd [result2], xmm0

    mov eax, [2]
    call print_float_array

    mov eax, 4
    mov ebx, 1
    mov ecx, 0xA
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80