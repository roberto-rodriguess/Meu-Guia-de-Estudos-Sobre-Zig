#include "worker2.h"
#include <stdio.h>
#include <string.h>

void process_data(char* buf1, char* buf2, const char* buf3) {
    // Escrever dados nos buffers passados pelo Zig (gerenciados pela Arena)
    strcpy(buf1, "Dados de teste escritos pelo C no buf1");
    strcpy(buf2, "Outros dados do C no buf2");
    printf("[C] Recebido buf3 do Zig: '%s'\n", buf3);
}
