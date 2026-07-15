const std = @import("std");

// Definindo um error set
const ErroArquivo = error {
    NaoEncontrado,
    PermissaoNegada,
    EmUso,
    EspacoInsuficiente,
};

// Error set vazio (nenhum erro possível)
const SemErro = error{};

// Função que retorna um erro específico
fn abrirArquivo(caminho: []const u8) ErroArquivo!Arquivo {
    if (caminho.len == 0) return error.NaoEncontrado;

    return Arquivo{};
}

// Struct de arquivo (exemplo)
const Arquivo = struct {
    handle: i32,
};

// Pode retornar qualquer erro
fn operacaoArriscada() anyerror!void {
    return error.AlgumErro;
}

// Útil para callbacks genéricos
const CallbalErro = fn () anyerror!void;

// T!E significa: valor do tipo T ou erro do error set E
const resultado: i32!ErroArquivo = 42;
const erro: i32!ErroArquivo = error.NaoEncontrado;

// Erro set implícito (infere do contexto)
const valor: !i32 = calcular();