#include <stdio.h>
#include "ziglib.h"

void imprimir(int n) {
    printf("Valor: %d\n", n);
}

int main() {
    printf("3 + 4 = %d\n", zig_soma(3, 4));
    printf("5! = %d\n", zig_fatorial(5));
    
    PontoZig p1 = {0.0, 0.0};
    PontoZig p2 = {3.0, 4.0};
    printf("Distância: %.2f\n", zig_distancia(p1, p2));
    
    int nums[] = {10, 20, 30};
    zig_processa_array(nums, 3, imprimir);
    
    return 0;
}