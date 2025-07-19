section .text
    global print_stack_trace

print_stack_trace:
    push ebp
    mov ebp, esp

    mov ebx, [ebp]

.stack_loop:
    cmp ebx, 0
    je .end_trace

    mov eax, [ebx+4]

    ; TODO: Print it

    mov ebx, [ebx]

    jmp .stack_loop

.end_trace:
    pop ebp
    ret