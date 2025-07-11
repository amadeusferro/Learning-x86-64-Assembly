section .data
    test_string db "Hello World 123!", 0
    output_msg db "String convertida: ", 0

section .text
global _start

to_upper:
    push ebp
    mov ebp, esp
    sub esp, 128 

    mov esi, [ebp+8] 
    mov edi, esp 

.process_char:
    lodsb              ;
    cmp al, 'a'
    jb .not_lower      
    cmp al, 'z'        
    ja .not_lower      
    sub al, 32         
.not_lower:
    stosb              
    test al, al        
    jnz .process_char  

    
    mov esi, esp       
    mov edi, [ebp+8]  
.copy_back:
    lodsb
    stosb
    test al, al
    jnz .copy_back

    mov esp, ebp
    pop ebp
    ret

print_string:
    mov eax, 4 
    mov ebx, 1 
    int 0x80
    ret

_start:
    mov edx, output_msg
    mov ecx, 19
    call print_string

    mov edx, test_string
    mov ecx, 16 
    call print_string

    mov edx, 0xA
    mov ecx, 1
    call print_string

    push test_string
    call to_upper
    add esp, 4

    mov edx, output_msg
    mov ecx, 19
    call print_string

    mov edx, test_string
    mov ecx, 16
    call print_string

    mov edx, 0xA
    mov ecx, esp
    sub esp, 1
    mov [esp], dl
    mov edx, esp
    mov ecx, 1
    call print_string
    add esp, 1

    mov eax, 1 
    xor ebx, ebx 
    int 0x80