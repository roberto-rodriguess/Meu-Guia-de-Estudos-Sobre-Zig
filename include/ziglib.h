#ifndef ZIGLIB_H
#define ZIGLIB_H

#ifdef __cplusplus
extern "C" {
#endif

int zig_soma(int a, int b);
int zig_fatorial(int n);

typedef struct {
    double x;
    double y;
} PontoZig;

double zig_distancia(PontoZig a, PontoZig b);

typedef void (*CallbackInt)(int);
void zig_processa_array(const int *arr, size_t len, CallbackInt callback);

#ifdef __cplusplus
}
#endif

#endif