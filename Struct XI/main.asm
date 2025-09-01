%define BankAccount_balance 0
%define BankAccount_deposit 8
%define BankAccount_withdraw 16
%define BankAccount_size 24

section .data
    fmt_balance db "New balance: $%d", 0xA, 0

section .text
    global main
    extern printf

account_deposit:
    push rbp
    mov rbp, rsp

    add [rdi + BankAccount_balance], rsi

    mov rsp, rbp
    pop rbp
    ret

account_withdraw:
    push rbp
    mov rbp, rsp

    sub [rdi + BankAccount_balance], rsi

    mov rsp, rbp
    pop rbp
    ret

main:
    push rbp
    mov rbp, rsp

    sub rsp, BankAccount_size

    mov qword [rsp + BankAccount_balance], 1000
    lea rax, [account_deposit]
    mov [rbp + BankAccount_deposit], rax
    lea rax, [account_withdraw]
    mov [rbp + BankAccount_withdraw], rax

    lea rdi, [rsp]
    mov rsi, 500
    call [rbp + BankAccount_deposit]

    mov rdi, fmt_balance
    mov rsi, [rsp + BankAccount_balance]
    xor rax, rax
    call printf

    lea rdi, [rsp]
    mov rsi, 200
    call [rbp + BankAccount_withdraw]

    mov rdi, fmt_balance
    mov rsi, [rsp + BankAccount_balance]
    xor rax, rax
    call printf

    add rsp, BankAccount_size

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall