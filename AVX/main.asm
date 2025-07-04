section .data
    align 32
    matrixA dd 1.0, 2.0, 3.0, 4.0,
            dd 5.0, 6.0, 7.0, 8.0,
            dd 9.0, 10.0, 11.0, 12.0,
            dd 13.0, 14.0, 15.0, 16.0

    align 32
    matrixB dd 1.0, 1.0, 1.0, 1.0,
            dd 2.0, 2.0, 2.0, 2.0,
            dd 3.0, 3.0, 3.0, 3.0,
            dd 4.0, 4.0, 4.0, 4.0

    align 32
    matrixC dd 0.0, 0.0, 0.0, 0.0,
            dd 0.0, 0.0, 0.0, 0.0,
            dd 0.0, 0.0, 0.0, 0.0,
            dd 0.0, 0.0, 0.0, 0.0

section .text
    global _start

_start:
    vmovaps ymm0, [matrixA] 
    vmovaps ymm1, [matrixB]  
    vaddps  ymm2, ymm0, ymm1
    vmovaps [matrixC], ymm2

    vmovaps ymm3, [matrixA + 32]  
    vmovaps ymm4, [matrixB + 32] 
    vaddps  ymm5, ymm3, ymm4 
    vmovaps [matrixC + 32], ymm5

    mov eax, 1 
    mov ebx, 0
    int 0x80
