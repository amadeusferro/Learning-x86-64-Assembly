section .text
    global main
    extern printf

section .data
    fmt db "Endereço de retorno: 0x%08x", 0x0A, 0

main:
    call  stack_trace

    mov eax, 1
    mov ebx, 0
    int 0x80

stack_trace:
    push ebp
    mov ebp, esp

    mov ebx, [ebp]

.loop:
    cmp ebx, 0
    je .loop_end

    mov eax, [ebx + 4]

    push eax,
    push fmt
    call printf
    add esp, 8

    mov ebx, [ebx]
    jmp .loop


.loop_end:
    pop ebp
    ret