#ifndef MINHA_CLASSE_HPP
#define MINHA_CLASSE_HPP

class MinhaClasse {
public:
    explicit MinhaClasse(int valor);
    ~MinhaClasse();

    int getValor() const;
    void setValor(int v);
    int dobrar() const;

private:
    int valor;
};

#endif
