const std = @import("std");

// Sucesso: retorna o valor diretamente
fn sucesso() !i32 {
    return 42;
}

// Erro: retorna um valor do error set
fn falha() !i32 {
    return error.Falha;
}

// Múltiplos erros possíveis
const MeuErro = error {ErroA, ErroB};
const OutroErro = error {ErroC};

fn podeFalharDeVariasFormas() (MeuErro || OutroErro)!i32 {
    return error.ErroA;
}

pub fn main() !void {
    const a = podeFalharDeVariasFormas();

    if (a) |s| {
        std.debug.print("sucesso", .{s});
    }
}
