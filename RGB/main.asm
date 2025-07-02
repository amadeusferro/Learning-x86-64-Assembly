section .data
    pixels dd 0.1, 0.2, 0.3, 1.0,   ; (R,G,B,A)
           dd 0.4, 0.5, 0.6, 1.0,
           dd 0.7, 0.8, 0.9, 1.0,
           dd 1.0, 1.1, 1.2, 1.0

    brightness dd 1.2, 1.2, 1.2, 1.2

section .text
    global _start:

_start:
    movaps xmm0, [pixels]
    movaps xmm1, [pixels+16]
    movaps xmm2, [pixels+32]
    movaps xmm3, [pixels+48]

    movaps xmm4, [brightness]

    mulps xmm0, xmm4
    mulps xmm1, xmm4
    mulps xmm2, xmm4
    mulps xmm3, xmm4

    movaps [pixels], xmm0
    movaps [pixels+16], xmm1
    movaps [pixels+32], xmm2
    movaps [pixels+48], xmm3

    mov eax, 1
    mov ebx, 0
    int 0x80