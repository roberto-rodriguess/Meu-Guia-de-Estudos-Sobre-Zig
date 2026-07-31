#include "minha-classe.hpp"

extern "C" {

// Opaque pointer para esconder C++
typedef struct MinhaClasseHandle MinhaClasseHandle;

MinhaClasseHandle* minha_classe_criar(int valor) {
    return reinterpret_cast<MinhaClasseHandle*>(new MinhaClasse(valor));
}

void minha_classe_destruir(MinhaClasseHandle* handle) {
    delete reinterpret_cast<MinhaClasse*>(handle);
}

int minha_classe_get_valor(MinhaClasseHandle* handle) {
    return reinterpret_cast<MinhaClasse*>(handle)->getValor();
}

void minha_classe_set_valor(MinhaClasseHandle* handle, int valor) {
    reinterpret_cast<MinhaClasse*>(handle)->setValor(valor);
}

int minha_classe_dobrar(MinhaClasseHandle* handle) {
    return reinterpret_cast<MinhaClasse*>(handle)->dobrar();
}

} // extern "C"
