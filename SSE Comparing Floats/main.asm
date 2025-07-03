section .data

float1  dd 6.6
float2  dd 6.6

msg_equal   db "Equal!", 0xA
equal_len   equ $ - msg_equal
msg_diff    db "Different!", 0xA
diff_len    equ $ - msg_diff

section .text
    global _start

_start:
    movss xmm0, [float1]
    movss xmm1, [float2]
    ucomiss xmm0, xmm1
    je .equal

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_diff
    mov edx, diff_len
    int 0x80
    jmp .exit

.equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    mov edx, equal_len
    int 0x80

.exit:
    mov eax, 1
    mov ebx, 0
    int 0x80