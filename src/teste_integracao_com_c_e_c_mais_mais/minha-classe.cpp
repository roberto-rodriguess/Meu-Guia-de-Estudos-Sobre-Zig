#include "minha-classe.hpp"

MinhaClasse::MinhaClasse(int v) : valor(v) {}
MinhaClasse::~MinhaClasse() = default;

int MinhaClasse::getValor() const { return valor; }
void MinhaClasse::setValor(int v) { valor = v; }
int MinhaClasse::dobrar() const { return valor * 2; }
