section .bss
    pseudo_heap resb 65536
    pseudo_heap_ptr resq 1

section .text
    global _start

_start:
    mov qword [pseudo_heap_ptr], pseudo_heap

    mov rdi, [pseudo_heap_ptr]
    mov rcx, 1024
    mov al, 'A'
    rep stosb

    mov rax, [pseudo_heap_ptr]
    mov byte [rax + 1023], 0xA

    mov rax, 1
    mov rdi, 1
    mov rsi, [pseudo_heap_ptr]
    mov rdx, 1024
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
