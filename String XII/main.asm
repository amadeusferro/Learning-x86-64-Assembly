%define size 8192

section .data
    very_long_string times size db 'X'
    result dq 0
    fmt db "Total sum: %ld", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    
    mov rsi, very_long_string
    mov rcx, size / 64
    xor rax, rax

.process_block:
    prefetchnta [rsi + 256]
    
    mov rdx, 64
    mov rdi, rsi
    
.process_64_bytes:
    movzx rbx, byte [rdi]
    add rax, rbx
    inc rdi
    dec rdx
    jnz .process_64_bytes
    
    add rsi, 64
    dec rcx
    jnz .process_block
    
    mov [result], rax
    
    mov rdi, fmt
    mov rsi, rax
    xor rax, rax
    call printf
    
    mov rsp, rbp
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall