const std = @import("std");

const Erro = error {DivisaoPorZero};

pub fn main() !void {
    const resultado = try dividir(10, 1);
    std.debug.print("Resultado: {d}\n", .{resultado});

    const seguro = dividir(10, 0) catch |err| {
        std.debug.print("Erro: {}\n", .{err});
        return;
    };

    std.debug.print("Resultado: {d}\n", .{seguro});
}

fn dividir(a: i32, b: i32) !i32 {
    if (b == 0) return Erro.DivisaoPorZero;

    return @divTrunc(a, b);
}
