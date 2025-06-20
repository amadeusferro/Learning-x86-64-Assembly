section .data
    num1    dd 10
    num2    dd 5
    sum     dd 0
    dif     dd 0

    msg_sum db  "Sum: "
    len_sum equ $ - msg_sum

    msg_dif db  "Subtraction: "
    len_dif equ $ - msg_dif

    newline db 0xA

section .bss
    buffer  resb 11         ; 10 digits + null terminator

section .text
    global _start

print_int:
    mov ecx, 10             ; ECX = 10 (divisor for decimal digits conversion)
    mov edi, buffer + 10    ; EDI points to the END of buffer (11th byte)
    mov byte [edi], 0       ; Add null terminator (0) at string end

    test eax, eax           ; Check if EAX == 0
    jnz .convert            
    dec edi                 ; If zero, move back 1 byte (to write '0')
    mov byte [edi], '0'     ; Store '0' character in buffer
    jmp .print      

.convert:
    xor edx, edx            ; Clear EDX (division remainder)
    div ecx                 ; Divide EAX by 10 (ECX) ; -> EAX = quotient, EDX = remainder (digit)
    add dl, '0'             ; Convert digit (0-9) to ASCII ('0'-'9')
    dec edi                 ; Move buffer pointer backward
    mov [edi], dl           ; Store ASCII digit in buffer
    test eax, eax           ; Check if EAX == 0 (finished?)
    jnz .convert

.print:
    mov esi, buffer + 10    ; ESI = end of buffer
    sub esi, edi            ; ESI = string length (end - current position)

    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, edi            ; string pointer
    mov edx, esi            ; string length
    int 0x80

    ret

_start:
    mov eax, [num1]
    add eax, [num2]
    mov [sum], eax

    mov eax, [num1]
    sub eax, [num2]
    mov [dif], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_sum
    mov edx, len_sum
    int 0x80

    mov eax, [sum]
    call print_int

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_dif
    mov edx, len_dif
    int 0x80

    mov eax, [dif]
    call print_int

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

; Command        Full name               Info
; ----------------------------------------------------------------------------------------------------------------------------------------------------
; resb           Reserve Bytes           Directive that allocates uninitialized memory space (content is undefined but usually zero in modern systems)
; test           -                       Instruction that performs bitwise AND between two operands but doesn't store result (only updates flags)
; jnz            jump if not zero        Jumps to label if ZF (Zero Flag) is not set (ZF = 0)
; dec            decrement               Subtracts 1 from specified register or memory address
; dl             -                       The low 8-bit part of the 32-bit edx register