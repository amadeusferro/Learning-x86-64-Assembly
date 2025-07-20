#include <stdio.h>


void stack_trace() {

    void ** ebp;
    asm volatile("mov %%ebp, %0" : "=r" (ebp));

    printf("Stack Trace:\n");
    while(ebp) {
        void* ret = *(ebp + 1);
        printf("[%p]\n", ret);
        ebp = (void**)(*ebp);
    }
}

void nihao() {
    stack_trace();
}

void salut() {
    nihao();
}

void konnichiwa() {
    salut();
}

void hello() {
    konnichiwa();
}

void hey() {
    hello();
}

int main() {
    
    hey();

    return 0;
}