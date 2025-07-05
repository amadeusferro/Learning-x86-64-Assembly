section .data
    align 64
    vectorA dd 1.2, 2.0, 7.5, 13.0, 11.5, 11.7, 15.06, 122.05, 15.033, 51.0, 13.30, 111.0, 17.0, 19.09, 13.0, 1.0
    vectorB dd 11.0, 15.05, 14.04, 11.10, 771.70, 41.40, 11.50, 61.70, 81.0, 71.0, 616.60, 14.0, 14.0, 14.0, 11.0, 1.0
    result dd 0.0

section .text
    global _start

_start:
    vmovaps zmm0, [vectorA]
    vmovaps zmm1, [vectorB]

    vxorps zmm2, zmm2, zmm2
    vfmadd231ps zmm2, zmm0, zmm1

    vextractf32x8 ymm0, zmm2, 0
    vextractf32x8 ymm1, zmm2, 1
    vaddps ymm0, ymm0, ymm1
    
    vhaddps ymm0, ymm0, ymm0
    vhaddps ymm0, ymm0, ymm0
    vhaddps ymm0, ymm0, ymm0

    vmovss [result], xmm0

    mov eax, 1
    xor ebx, ebx
    int 0x80