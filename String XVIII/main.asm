section .data
    fmt db "%d", 0xA, 0
    myString db "Hello, world!", 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rdi, myString
    call strlen

    mov rdi, fmt
    mov rsi, rax
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

strlen:
    push rbp
    mov rbp, rsp

    push rdi

    mov rcx, rdi
    and rcx, -8
    
    mov rax, rdi
    sub rax, rcx 
    shl rax, 3
    mov rdx, 64
    sub rdx, rax
    
    mov rax, [rcx]
    add rcx, 8
    
    mov r10, -1 
    shl r10, cl
    not r10
    or rax, r10
    
    mov r8, 0x0101010101010101
    mov r9, 0x8080808080808080

.aligned_loop:
    mov rsi, rax
    sub rax, r8
    not rsi
    and rax, rsi
    and rax, r9
    jnz .found_zero
    
    mov rax, [rcx]
    add rcx, 8
    jmp .aligned_loop

.found_zero:
    bsf rax, rax 
    shr rax, 3 
    
    lea rax, [rcx + rax - 8] 
    pop rdi 
    sub rax, rdi

    mov rsp, rbp
    pop rbp
    ret