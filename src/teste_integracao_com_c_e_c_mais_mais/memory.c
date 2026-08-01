#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Exemplo Seguro: Passando Strings
void processa_string(const char *s) {
    printf("[C] processa_string: \"%s\"\n", s);
}

// C aloca e C libera
char* cria_string(void) {
    const char *orig = "Alocado em C usando malloc";
    char *s = malloc(strlen(orig) + 1);
    if (s == NULL) return NULL;
    strcpy(s, orig);
    return s;
}

void libera_string(char *s) {
    if (s != NULL) {
        free(s);
    }
}

// C recebe buffer gerenciado por Zig
void recebe_buffer(char *buf, size_t len) {
    if (len == 0 || buf == NULL) return;

    const char *msg = "Dados gravados pelo C no buffer da Arena/c_allocator do Zig";
    size_t msg_len = strlen(msg);
    size_t write_len = msg_len < (len - 1) ? msg_len : (len - 1);
    
    memcpy(buf, msg, write_len);
    buf[write_len] = '\0';
    
    printf("[C] recebe_buffer: buffer preenchido com sucesso (%zu bytes).\n", write_len);
}
