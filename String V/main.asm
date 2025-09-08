section .data
    utf8_str db "Café", 0   ; "Café" = 43 61 66 C3 A9 00

section .text
    global main
    extern print

main:
    push rbp
    mov rbp, rsp

    mov rsi, utf8_str

.process_utf8:
    movzx eax, byte [rsi] 
    test al, al
    jz .done

    cmp al, 0x80
    jb .ascii_char          ; if < 0x80 → ASCII (1 byte)

    cmp al, 0xE0
    jb .two_byte            ; 110xxxxx → 2 bytes
    cmp al, 0xF0
    jb .three_byte          ; 1110xxxx → 3 bytes
    jmp .four_byte          ; 11110xxx → 4 bytes

.ascii_char:
    add rsi, 1
    jmp .process_utf8

.two_byte:
    add rsi, 2
    jmp .process_utf8

.three_byte:
    add rsi, 3
    jmp .process_utf8

.four_byte:
    add rsi, 4
    jmp .process_utf8

.done:
    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi 
    syscall