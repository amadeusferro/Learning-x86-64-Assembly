section .data
    alloc_msg db "Simple allocator in ASM", 0xA, 0
    alloc_msg_len equ $ - alloc_msg
    newline db 0xA

section .bss
    heap_start resq 1  

section .text
    global _start

my_malloc:
    push rbp
    mov rbp, rsp

    add rdi, 15
    and rdi, -16
    add rdi, 8    

    cmp qword [heap_start], 0
    jne .allocate_memory    

.initialize_heap:
    mov rax, 12         
    push rdi            
    xor rdi, rdi        
    syscall
    pop rdi              
    mov [heap_start], rax 

.allocate_memory:
    mov rbx, [heap_start]  
    
    mov rax, 12          
    mov r10, rdi        
    mov rdi, rbx       
    add rdi, r10      
    syscall

    add rbx, r10     
    cmp rax, rbx
    jne .error        

    mov [heap_start], rax 

    mov rax, [heap_start] 
    sub rax, r10           
    add rax, 8             
    
    jmp .done

.error:
    xor rax, rax   

.done:
    leave
    ret

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, alloc_msg
    mov rdx, alloc_msg_len
    syscall

    mov rdi, 64
    call my_malloc
    test rax, rax
    jz exit_error

    mov r15, rax

    mov rdi, r15
    mov rcx, 64
    mov al, 'A'
    rep stosb

    mov rax, 1
    mov rdi, 1
    mov rsi, r15
    mov rdx, 16
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

exit_error:
    mov rax, 60
    mov rdi, 1
    syscall