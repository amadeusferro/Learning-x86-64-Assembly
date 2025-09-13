section .data
    buffer times 17 db 0 
    input_msg db 'Enter text (max 16 chars): ', 0
    fmt db "%s", 0 

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rax, 1
    mov rdi, 1
    mov rsi, input_msg
    mov rdx, 26
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 16 
    syscall

    cmp rax, 16
    jb .no_overflow 
    
.clean_buffer:
    mov rax, 0   
    mov rdi, 0      
    mov rsi, buffer   
    mov rdx, 1   
    syscall
    
    cmp byte [buffer], 10  
    jne .clean_buffer 

.no_overflow:
    mov byte [buffer + rax], 0

    mov rdi, fmt
    mov rsi, buffer
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall