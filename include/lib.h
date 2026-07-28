#ifndef MINHA_LIB_H
#define MINHA_LIB_H

typedef struct {
    int x;
    int y;
} Ponto;

Ponto criar_ponto(int x, int y);
int distancia(Ponto a, Ponto b);

#endif
