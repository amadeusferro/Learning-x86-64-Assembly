%define Student_name     0
%define Student_grades   8
%define Student_num_grades 16
%define Student_size     24

section .data
    fmt_student db "Student: %s, Grades: %d, %d, %d", 0xA, 0
    student_name db "Carlos", 0
    grades_array dd 85, 90, 78

    mmap_error_msg db "Error during memory allocation", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rax, 9 
    xor rdi, rdi
    mov rsi, Student_size 
    mov rdx, 0x3  
    mov r10, 0x22 
    mov r8, -1 
    xor r9, r9 
    syscall

    cmp rax, -1
    je .mmap_error
    mov r15, rax

    lea rsi, [student_name]
    mov rdi, r15 + Student_name
    mov rcx, 16
    rep movsb

    lea rax, [grades_array]
    mov [r15 + Student_grades], rax

    mov dword [r15 + Student_num_grades], 3

    mov rdi, fmt_student
    mov rsi, r15 
    
    mov rax, [r15 + Student_grades]  
    mov edx, [rax]   
    mov ecx, [rax + 4] 
    mov r8d, [rax + 8] 
    xor rax, rax 
    call printf

    mov rax, 11   
    mov rdi, r15  
    mov rsi, Student_size 
    syscall

    mov rsp, rbp
    pop rbp

    mov rax, 60   
    xor rdi, rdi     
    syscall

.mmap_error:
    mov rdi, mmap_error_msg
    call printf

    mov rax, 60
    mov rdi, 1
    syscall