section .data
    num dd -10

section .bss
    buffer resb 12

section .text
    global _start

print_num:
    mov ecx, 10     
    mov edi, buffer + 11  
    mov byte [edi], 0
    
    test eax, eax       
    jns .convert          
    
    neg eax                
    mov byte [buffer], '-' 
    jmp .convert

.convert:
    xor edx, edx      
    div ecx                 
    add dl, '0'           
    dec edi                
    mov [edi], dl        
    test eax, eax         
    jnz .convert         

    cmp byte [buffer], '-'
    jne .print
    dec edi                 
    mov byte [edi], '-'

.print:
    mov ecx, edi           
    mov edx, buffer + 12  
    sub edx, edi
    
    mov eax, 4      
    mov ebx, 1         
    int 0x80
    ret

_start:
    mov eax, [num]
    call print_num

    mov eax, 1
    mov ebx, 0        
    int 0x80