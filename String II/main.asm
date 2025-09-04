section .data
    src db "Morbi leo mi, nonummy eget, tristique non, rhoncus non, leo. Nullam faucibus mi quis velit. Integer in sapien. Fusce tellus odio, dapibus id, fermentum quis, suscipit id, erat. Fusce aliquam vestibulum ipsum. Aliquam erat volutpat. Pellentesque sapien. Cras elementum. Nulla pulvinar eleifend sem. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Quisque porta. Vivamus porttitor turpis ac leo. In sem justo, commodo ut, suscipit at, pharetra vitae, orci. Duis sapien nunc, commodo et, interdum suscipit, sollicitudin et, dolor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam id dolor. Class aptent taciti sociosqu ad litora torquenet per conubia nostra, per inceptos hymenaeos. Mauris dictum facilisis augue. Fusce tellus. Pellentesque arcu. Maecenas fermentum, sem in pharetrsa pellentesque, velit turpis volutpat ante, in pharetra metus odio a lectus. Sed elit dui, pellentesque a, faucibus vel, interdum nec, diam. Mauris dolor.", 0
    dest times 1025 db 0
    fmt db "%s", 0xA, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rcx, 1024
    mov rsi, src
    mov rdi, dest
    cld
    rep movsb

    mov rdi, fmt
    mov rsi, dest
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall