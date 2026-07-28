#include "lib.h"
#include <math.h>

Ponto criar_ponto(int x, int y) {
    Ponto p = {x, y};
    return p;
}

int distancia(Ponto a, Ponto b) {
    double dx = (double)(a.x - b.x);
    double dy = (double)(a.y - b.y);
    return (int)sqrt(dx * dx + dy * dy);
}