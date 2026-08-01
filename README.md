# Zig Lab: Meu Guia de Estudos 🔬

Este é um repositório dedicado aos meus estudos e experimentos práticos com a linguagem de programação **Zig** (utilizando a versão **0.16.0**).

O objetivo deste projeto é documentar o meu aprendizado de forma didática, cobrindo desde a sintaxe mais básica e primitivos até conceitos avançados de gerenciamento de memória, metaprogramação (`comptime`) e integração com a linguagem C (FFI) e C++.

---

## 📂 Estrutura do Projeto

Os arquivos de código fonte estão organizados dentro da pasta `src/` e divididos por tópicos sequenciais de aprendizado:

1. **[teste_identificadores/](src/teste_identificadores)**: Regras de nomes, sintaxe e caracteres especiais.
2. **[conversao_de_tipos/](src/conversao_de_tipos)**: Conversão implícita (coercion) e explícita (casting) de tipos.
3. **[teste_esruturas_de_decisao/](src/teste_esruturas_de_decisao)**: Condicionais (`if`/`else`), estruturas `switch` e loops (`for`, `while`, desdobramento inline).
4. **[teste_funcoes/](src/teste_funcoes)**: Assinaturas de funções, visibilidade, escopos e funções anônimas.
5. **[teste_strings_e_arrays/](src/teste_strings_e_arrays)**: Arrays, slices, `ArrayList` e manipulação/formatação de strings.
6. **[teste_import/](src/teste_import)**: Organização de projetos e importação de arquivos locais com `@import`.
7. **[structs_enums_unions/](src/structs_enums_unions)**: Tipos de dados estruturados, métodos e opcionais.
8. **[teste_errors/](src/teste_errors)**: Tratamento de erros, error sets, uniões de erro, `try`, `catch` e `errdefer`.
9. **[teste_alocacao_de_memoria/](src/teste_alocacao_de_memoria)**: Alocação explícita na heap e gerenciamento manual de memória com diferentes alocadores.
10. **[teste_testes/](src/teste_testes)** & **[tests/](tests)**: Escrita de testes de unidade e testes de integração nativos.
11. **[teste_comptime/](src/teste_comptime)**: Execução de código em tempo de compilação, genéricos e introspecção.
12. **[teste_integracao_com_c_e_c_mais_mais/](src/teste_integracao_com_c_e_c_mais_mais)**: FFI com a LibC, estruturação de dados em C, callbacks assíncronos, gerenciamento de memória em arena, wrappers idiomáticos do **SQLite3**, **cURL**, **Worker**, **Worker2**, **clog**, integração com **C++**, gerenciamento de ponteiros/memória através de fronteiras FFI e leitura de dados do teclado sem usar FFI do C (nativa do Zig).
13. **[teste_usando_codigo_c_em_zig/](src/teste_usando_codigo_c_em_zig)**: Compilação de código C híbrido e uso de translate-c.
14. **[teste_exportando_funcoes_pra_c/](src/teste_exportando_funcoes_pra_c)**: Exportação de funções Zig para uso direto em códigos C.
15. **[exercicios/](src/exercicios)**: Exercícios de aplicação e leitura/escrita de arquivos.

### 🌐 Pastas Globais para Bibliotecas C/C++:
* **`include/`**: Contém os arquivos de cabeçalho C/C++ (`.h` / `.hpp`), como o `sqlite3.h`, `mylib.h`, `worker.h`, `worker2.h`, `clog.h`, `lib.h`, `minha-classe.hpp` e a subpasta `curl/`.
* **`include/lib/`**: Contém os arquivos de código-fonte C compilados nativamente (`sqlite3.c`).
* **`lib/`**: Contém as bibliotecas externas do cURL para Windows MinGW (`libcurl.dll.a`, `libcurl.a`, etc.).
* **`build_files/`**: Pasta que centraliza todos os scripts individuais de build numerados.
* **`src/util/`**: Pasta com utilitários gerais compartilhados do projeto (`system.zig`, `keyboard.zig`).

---

## 🛠️ Sistema de Build do Zig

O projeto possui um despachante dinâmico principal (`build.zig`) e vários arquivos de build numerados de acordo com o progresso dos estudos. Cada script configura uma parte específica do aprendizado:

* **`build.zig`**: Despachante raiz dinâmico. Permite trocar qual exercício rodar passando `-Dexercicio=N` (padrão: exercício 22).
* **`build_files/build-01-testes-integracao.zig`**: Configura e roda os testes de integração do projeto.
* **`build_files/build-02-integracao-libc.zig`**: Compila exemplos que ligam e chamam recursos da LibC.
* **`build_files/build-03-usar-codigo-c-no-zig.zig`**: Traduz e compila arquivos `.c` e `.h` locais para serem importados no Zig.
* **`build_files/build-04-exportar-zig-para-c.zig`**: Exporta uma biblioteca estática compilada em Zig para ser usada por um executável C.
* **`build_files/build-05-executar-exercicios.zig`**: Registra passos individuais de execução para arquivos da pasta de exercícios.
* **`build_files/build-06-instalar-exercicios.zig`**: Compila e copia os binários dos exercícios na pasta de saída `zig-out/`.
* **`build_files/build-07-completo-exercicios-e-testes.zig`**: Integra todo o executável, testes de unidade e testes de integração em um só lugar.
* **`build_files/build-08-teste_importando_c_sqlite3.zig`**: Exemplo básico de importação do cabeçalho do SQLite3.
* **`build_files/build-09-importando_bibliotecas_c_externas.zig`**: Compila o código fonte C do SQLite3 (`sqlite3.c`) diretamente no projeto com suporte total do Zig.
* **`build_files/build-10-wrapping-funcao-c.zig`**: Compila e executa o encapsulamento em Zig de chamadas FFI da biblioteca dinâmica externa do **cURL**.
* **`build_files/build-11-trabalhando-com-structs-c.zig`**: Compilação e linkagem da biblioteca customizada local `mylib`.
* **`build_files/build-12-criando_wrappers_idiomaticos.zig`**: Criação de wrappers orientados a objeto em Zig para structs do C.
* **`build_files/build-13-recebendo-callbacks-c.zig`**: Demonstração de passagem e recebimento de ponteiros de função de progresso (Callbacks) do C em Zig.
* **`build_files/build-14-padrao-arena-allocator-c.zig`**: Exemplo de alocação de memória usando padrão Arena Allocator em Zig com passagem para C.
* **`build_files/build-15-gerenciamento-memoria-fronteiras.zig`**: Compilação e testes de limites/segurança de alocação de memória FFI.
* **`build_files/build-16-wrapper_idiomatico_de_biblioteca_c.zig`**: Encapsulamento prático e isolamento completo de uma biblioteca de logs em C (`clog`) por baixo de uma API amigável em Zig.
* **`build_files/build-17-criando_um_wrapper_idiomatico.zig`**: Compilação de uma biblioteca estática em C (`lib.c`) e sua linkagem com o executável Zig correspondente.
* **`build_files/build-18-exportando_funcoes_zig_para_c.zig`**: Compilação de funções e tipos estruturados do Zig como uma biblioteca dinâmica (`.dll`/`.lib`) para consumo por código C externo.
* **`build_files/build-19-chamando_zig_a_partir_de_c.zig`**: Compilação de executável em C (`main.c`) linkado dinamicamente com a DLL do Zig (`ziglib.dll`).
* **`build_files/build-20-integracao_com_c_mais_mais.zig`**: Compilação de classes C++ e criação de wrapper compatível com o FFI do Zig (linkado com a C++ Standard Library `libc++`).
* **`build_files/build-21-gerenciamento_de_memoria_atraves_de_fronteiras.zig`**: Demonstração prática e regras de segurança para alocação/liberação de memória entre as fronteiras FFI do Zig e C.
* **`build_files/build-22-leitura_teclado_nativa.zig`**: Compilação de aplicação com módulos registrados compartilhados (`util_keyboard` e `util_system`) demonstrando a entrada de dados (readLine, readInt, readFloat) 100% nativa do Zig sem FFI.

### Como rodar:
* Para rodar o exercício atual via roteador (padrão 22):
  ```powershell
  zig build run
  ```
* Para rodar um exercício específico (ex: exercício 21 ou 22):
  ```powershell
  zig build -Dexercicio=21 run
  ```
* Para rodar um build diretamente via arquivo:
  ```powershell
  zig build --build-file build_files/build-22-leitura_teclado_nativa.zig run
  ```

---

## 📂 Requisitos e Execução

* **Compilador:** Zig `0.16.0` ou superior.
* Para executar um arquivo simples sem gerar um build completo:
  ```powershell
  zig run src/caminho_do_arquivo.zig
  ```
