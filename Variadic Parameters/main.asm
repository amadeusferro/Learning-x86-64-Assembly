section .data
    fmt db "Numbers: %d, %x", 10, 0
    num_int dd 42
    int_buffer times 12 db 0

section .text
    global _start

_start:
    push dword 0xDEADBEEF
    push dword [num_int]
    push fmt
    call my_printf
    add esp, 12

    ; exit(0)
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ===================== printf simplificado ======================
my_printf:
    push ebp
    mov ebp, esp
    push ebx            
    push esi              

    mov esi, [ebp+8]      
    lea ebx, [ebp+12]      

.process_fmt:
    lodsb                 
    test al, al
    jz .end

    cmp al, '%'
    jne .print_char

    lodsb                  
    cmp al, 'd'
    je .print_int
    cmp al, 'x'
    je .print_hex
    jmp .process_fmt    

.print_int:
    mov eax, [ebx]
    add ebx, 4
    push eax
    call print_int
    add esp, 4
    jmp .process_fmt

.print_hex:
    mov eax, [ebx]
    add ebx, 4
    push eax
    call print_hex
    add esp, 4
    jmp .process_fmt

.print_char:
    push eax              
    mov eax, 4          
    mov ecx, esp         
    mov edx, 1          
    push ebx              
    mov ebx, 1       
    int 0x80
    pop ebx              
    pop eax            
    jmp .process_fmt

.end:
    pop esi               
    pop ebx              
    mov esp, ebp
    pop ebp
    ret

print_int:
    push ebp
    mov ebp, esp
    push ebx                
    push edi                

    mov eax, [ebp+8]       
    mov edi, int_buffer + 11
    mov byte [edi], 0      
    mov ecx, 10           

    test eax, eax           
    jnz .convert_loop
    mov byte [edi-1], '0'  
    dec edi
    jmp .print

.convert_loop:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convert_loop

.print:
    mov eax, 4           
    mov ebx, 1             
    mov ecx, edi         
    mov edx, int_buffer + 11
    sub edx, edi          
    int 0x80

    pop edi              
    pop ebx               
    pop ebp
    ret

print_hex:
    push ebp
    mov ebp, esp
    push ebx               
    push edi              

    mov eax, [ebp+8]       
    mov edi, int_buffer + 8 
    mov ecx, 8            

.hex_loop:
    mov edx, eax
    and edx, 0xF          
    cmp dl, 9
    jbe .digit
    add dl, 'A' - 10      
    jmp .store
.digit:
    add dl, '0'           
.store:
    dec edi
    mov [edi], dl
    shr eax, 4            
    loop .hex_loop

    mov eax, 4            
    mov ebx, 1           
    mov ecx, edi       
    mov edx, 8            
    int 0x80

    pop edi             
    pop ebx                
    pop ebp
    ret