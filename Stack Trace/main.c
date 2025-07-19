#include <stdio.h>

void print_stack_tracee() {
    void **ebp;
    asm volatile ("mov %%ebp, %0" : "=r" (ebp));

    printf("Stack Trace:\n");
    while(ebp) {
        void *ret_addr = *(ebp+1);
        printf("  [%p]\n", ret_addr);
        ebp = (void **)(*ebp);
    }
}

void hey() {
    print_stack_tracee();
}

void hello() {

    hey();

}

int main() {

    hello();

    return 0;
}