const std = @import("std");

const ErroBaixoNivel = error {Io, Timeout};
const ErroAltoNivel = error {CarregamentoFalhou};

const Dados = struct {};
fn abrirArquivo() ErroBaixoNivel!i32 {}

fn carregarDados() ErroAltoNivel!Dados {
    const arquivo = abrirArquivo() catch |err| {
        std.log.err("Falha de IO: {}", .{err});
        return ErroAltoNivel.CarregamentoFalhou;
    };
    _ = arquivo;
    return Dados{};
}