section .data

float1  dd 6.6
float2  dd 6.7

msg_equal   db "Equal!", 0xA
equal_len   equ $ - msg_equal
msg_diff    db "Different!", 0xA
diff_len    equ $ - msg_diff

section .text
    global _start

_start:
    fld dword [float1]
    fld dword [float2]
    fcompp
    fstsw ax   ; (Store Status Word) The FPU sets bits in its own Status Word after a floating-point comparison (like fcom or fcompp)
    sahf       ; (Store AH into Flags) This takes the high byte of AX (i.e., AH) — where the fstsw stored the condition bits — and copies them into the CPU's flags register (EFLAGS)
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