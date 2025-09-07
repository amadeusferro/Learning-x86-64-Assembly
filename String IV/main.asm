section .data
    str1          db "This is a long string that we want to process quickly", 0
    str2          db "This is a long string that we want to process quickly", 0

    fmt           db "%s", 0
    equal_msg     db "Equal!", 0xA, 0
    not_equal_msg db "Not Equal!", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, str1
    mov rdi, str2
    
    movdqu xmm0, [rsi]
    movdqu xmm1, [rdi]

    pcmpeqb xmm0, xmm1
    pmovmskb eax, xmm0

    cmp eax, 0xFFFF
    jne .mismatch

    add rsi, 16
    add rdi, 16
    
    ; It should continue processing !

    mov rsi, equal_msg
    jmp .exit

.mismatch:
    mov rsi, not_equal_msg

.exit:

    mov rdi, fmt
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall