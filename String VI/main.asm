section .data
    main_str        db "This is the main string to search in", 0
    sub_str         db "main", 0
    fmt             db "%s", 0
    found_msg       db "Found!", 0xA, 0
    not_found_msg   db "Not Found!", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rsi, main_str
    mov rdi, sub_str

.outer_loop:
    mov rbx, rsi
    mov rcx, rdi

.inner_loop:
    mov al, [rcx]
    test al, al
    jz .found

    cmp al, [rsi]
    jne .next_char

    inc rsi
    inc rcx
    jmp .inner_loop

.next_char:
    inc rbx
    mov rsi, rbx
    cmp byte [rsi], 0
    jne .outer_loop

.not_found:
    mov rsi, not_found_msg
    jmp .exit

.found:
    mov rsi, found_msg

.exit:
    mov rdi, fmt
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    mov rax, 60
    xor rdi, rdi
    syscall