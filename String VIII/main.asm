section .data
    str1 db "Hello, ", 0
    str2 db "World!", 0
    result times 32 db 0
    fmt db  "%s", 0xA, 0

section .text
    global main
    extern printf

strlen:
    xor rax, rax
.loop:
    cmp byte [rdi+rax], 0
    je .done
    inc rax
    jmp .loop
.done:
    ret

main:
    push rbp
    mov rbp, rsp
    
    mov rdi, str1
    call strlen
    mov rsi, str1
    mov rdi, result
    mov rcx, rax
    rep movsb
    
    push rdi
    
    mov rdi, str2
    call strlen
    mov rsi, str2
    pop rdi
    mov rcx, rax
    rep movsb
    
    mov byte [rdi], 0
    
    mov rdi, fmt
    mov rsi, result
    xor rax, rax
    call printf
    
    mov rsp, rbp
    pop rbp
    
    mov rax, 60
    xor rdi, rdi
    syscall