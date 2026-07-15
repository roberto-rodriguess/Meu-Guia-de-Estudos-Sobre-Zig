#include <stdio.h>
#include <stdint.h>

// Declaracoes das funcoes exportadas pelo Zig
extern int32_t somar(int32_t a, int32_t b);
extern uint64_t fatorial(uint32_t n);
extern uint8_t* criar_buffer(size_t tamanho);
extern void liberar_buffer(uint8_t* ptr, size_t tamanho);

int main(void) {
    // Chamar funcoes Zig normalmente
    printf("3 + 4 = %d\n", somar(3, 4));
    printf("10! = %lu\n", fatorial(10));

    // Gerenciar memoria alocada pelo Zig
    uint8_t* buf = criar_buffer(1024);
    if (buf) {
        buf[0] = 42;
        printf("buf[0] = %d\n", buf[0]);
        liberar_buffer(buf, 1024);
    }

    return 0;
}