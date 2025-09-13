section .data
    align 16
    optimized_str db "abcdefghijkl7m.", 0

    align 16
    buffer times 256 db 0

    align 16
    lower_a db 96,96,96,96,96,96,96,96,96,96,96,96,96,96,96,96
    lower_z db 122,122,122,122,122,122,122,122,122,122,122,122,122,122,122,122
    all_ones db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
    mask_20 db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
    format db "Resultado: %s", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, optimized_str
    test rsi, 0xF
    jz .aligned
    
    and rsi, -16
    add rsi, 16

.aligned:
    movdqa xmm0, [rsi]
    movdqa xmm1, xmm0
    
    movdqa xmm2, xmm0
    pcmpgtb xmm2, [lower_a]
    movdqa xmm3, xmm0
    pcmpgtb xmm3, [lower_z]
    pxor xmm3, [all_ones]
    pand xmm2, xmm3
    pand xmm2, [mask_20]
    psubb xmm0, xmm2 
    
    movdqa [buffer], xmm0
    
    lea rdi, [format]
    lea rsi, [buffer]
    call printf
    
    mov rsp, rbp
    pop rbp
    
    mov rax, 60
    xor rdi, rdi
    syscall
