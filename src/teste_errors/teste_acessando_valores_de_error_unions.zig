const std = @import("std");

const ErroExemplo = error {
    ValorInvalido,
    FalhaAleatoria,
};

fn podeFalhar() ErroExemplo!i32 {
    const sucesso = false;

    if (sucesso) {
        return 42;
    } else {
        return ErroExemplo.ValorInvalido;
    }
}

pub fn main() !void {
    const resultado = podeFalhar();

    if (resultado) |valor| {
        std.debug.print("Sucesso: {d}\n", .{valor});
    } else |err| {
        std.debug.print("Erro: {}\n", .{err});
    }
}
