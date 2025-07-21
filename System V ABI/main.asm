section .data
    value1: dq 3.5
    value2: dq 1.2

section .text
    global calcule
    global _start        

calcule:
    ; a em EDI
    ; b em XMM0
    ; c em ESI
    ; d em XMM1
    ; e em EDX (não usado)
    ; f em ECX (não usado)

    cvtsi2sd xmm2, edi
    cvtsi2sd xmm3, esi

    addsd xmm0, xmm2      ; xmm0 = b + a
    addsd xmm1, xmm3      ; xmm1 = d + c
    mulsd xmm0, xmm1      ; xmm0 = (b + a) * (d + c)

    ret

_start:                
    mov edi, 2
    movsd xmm0, [value1]
    mov esi, 4
    movsd xmm1, [value2]
    mov edx, 5
    mov ecx, 6

    call calcule        

    mov rax, 60         
    xor rdi, rdi 
    syscall
