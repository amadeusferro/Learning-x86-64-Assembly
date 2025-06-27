section .data
    newline     db  10
    msg1        db "## Integer Input Multiplication ##"
    msg1_len   equ $ - msg1
    msg2        db "Write de first number: "
    msg2_len   equ $ - msg2
    msg3        db "Write de second number: "
    msg3_len   equ $ - msg3
    msg4        db "Result: "
    msg4_len   equ $ - msg4
    msg_error   db "Error! Something wrong happend!"
    msg_error_len    equ $ - msg_error

    num1        dd 0
    num2        dd 0
    result      dd 0

section .bss
    buffer resb 12
    input_buffer resb 33

section .text
    global _start

print_int:
    mov byte [buffer], '+'
    mov ecx, 10
    mov edi, buffer + 11
    mov byte [edi], 0

    test eax, eax
    jz .zero
    js  .negative

.convert:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi 
    mov byte [edi], dl
    test eax, eax
    jnz .convert

    cmp byte [buffer], '-'
    jne .print
    dec edi
    mov byte [edi], '-'

.print:
    mov esi, buffer + 11
    sub esi, edi

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, esi
    int 0x80
    ret

.zero:
    dec edi
    mov byte [edi], '0'
    jmp .print

.negative:
    neg eax
    mov byte [buffer], '-'
    jmp .convert

string_to_int:
    mov esi, 1

    cmp byte [edi], 32 ; ' '
    je .blank

.check_signal:
    cmp byte [edi], 45 ; '-'
    je .negative

    cmp byte [edi], 43 ; '+'
    je .positive

    cmp byte [edi], 48 ; '0'
    je .zeros

    mov eax, 0

.check_number_bounds:
    cmp byte [edi], 48 ; '0'
    jl .error

    cmp byte [edi], 57 ; '9'
    jg .error

.convert_number:
    mov edx, 10
    imul edx
    
    mov ecx, [edi]
    sub cl, 48 ; '0'
    add al, cl
    
    inc edi
    cmp byte [edi], 0
    jne .check_number_bounds

    imul esi
    mov [ebx], eax
    ret

.blank:
    inc edi
    cmp byte [edi], 32 ; ' '
    je .blank
    jmp .check_signal

.negative:
    mov esi, -1
    inc edi
    jmp .check_number_bounds

.positive:
    inc edi
    jmp .check_number_bounds

.zeros:
    inc edi
    cmp byte [edi], 48 ; '0'
    je .zeros
    jmp .check_number_bounds

.error:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_error
    mov edx, msg_error_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
    ; ret

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, input_buffer
    mov edx, 32
    int 0x80

    mov esi, input_buffer
    add esi, eax
    dec esi
    mov byte [esi], 0

    mov ebx, num1
    mov edi, input_buffer
    call string_to_int

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msg3_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, input_buffer
    mov edx, 32
    int 0x80

    mov esi, input_buffer
    add esi, eax
    dec esi
    mov byte [esi], 0

    mov ebx, num2
    mov edi, input_buffer
    call string_to_int

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, msg4_len
    int 0x80

    mov eax, [num1]
    imul dword [num2]
    mov [result], eax

    mov eax, [result]
    call print_int

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80