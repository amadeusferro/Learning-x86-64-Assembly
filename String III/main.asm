section .data
    str1 db "test1", 0
    str2 db "test", 0
    fmt db "%s", 0
    equal_msg db "Equal!", 0xA, 0
    not_equal_msg db "Not Equal!", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rdi, str1
    mov rsi, str2 
    cld

.compare_loop:
    cmpsb
    jne .not_equal
    mov al, [rdi-1]
    test al, al
    jnz .compare_loop

    mov rsi, equal_msg
    jmp .exit

.not_equal:
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