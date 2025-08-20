section .text
    global _start

_start:
    mov rdi, 30
    
    add rdi, 15 
    and rdi, -16
    
    
    mov rax, 9       
    xor rdi, rdi    
    mov rsi, rdi       
    mov rdx, 0x3       
    mov r10, 0x22       
    mov r8, -1        
    xor r9, r9   
    syscall
    
    mov r15, rax 
    
    test rax, 0xF 
    jz is_aligned 
    
    add rax, 15
    and rax, -16
    
is_aligned:
    
    ; use allocated memory here
    
    mov rdi, r15
    mov rsi, 32 
    mov rax, 11 
    syscall
    
    mov rax, 60
    xor rdi, rdi
    syscall