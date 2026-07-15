const std = @import("std");

const Erro = error {Falhou};

fn podeFalhar() Erro!i32 {
    const falhou = true;

    if (falhou) return Erro.Falhou;

    return 2;
}

pub fn main() void {
    // catch com valor padrão
    const resultado = podeFalhar() catch 0;
    std.debug.print("resultado: {d}\n", .{resultado});

    // catch com bloco
    const resultado2 = podeFalhar() catch |err| blk: {
        std.debug.print("Erro: {}\n", .{err});
        break :blk -1;
    };

    std.debug.print("Resultado2: {d}\n", .{resultado2});
}
