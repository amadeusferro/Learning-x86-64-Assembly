section .data
    input_string db "MixedCaseString123", 0
    fmt db "%s", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, input_string
    mov rdi, rsi

.convert_case:
    mov al, [rdi]
    test al, al
    jz .done

    mov bl, al
    sub bl, 'A'
    cmp bl, 25
    setna cl
    movzx ecx, cl
    shl ecx, 5
    add al, cl

    mov [rdi], al
    inc rdi
    jmp .convert_case

.done:
    mov rdi, fmt
    mov rsi, input_string
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall