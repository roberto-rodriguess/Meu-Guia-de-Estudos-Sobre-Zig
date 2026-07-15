const std = @import("std");

const Erro = error {ValorInvalido};

fn processarValores() !void {
    const valores = [_]i32 {1, 2, -1, 4};

    for (valores) |valor| {
        if (valor < 0) {
            return Erro.ValorInvalido;
        }
        std.debug.print("Processando: {d}\n", .{valor});
    }
}

pub fn main() void {
    processarValores() catch |err| {
        std.debug.print("Erro durante processamento: {}\n", .{err});
    };
}
