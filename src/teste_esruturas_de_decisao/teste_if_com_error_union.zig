const std = @import("std");

const Erro = error {DivisaoPorZero};

pub fn main() void {
    const resultado = divide(10, 2);

    if (resultado) |valor| {
        std.debug.print("Resultado: {d}\n", .{valor});
    } else |err| {
        std.debug.print("Erro: {}\n", .{err});
    }
}

fn divide(a: i32, b: i32) Erro!i32 {
    if (b == 0) return Erro.DivisaoPorZero;
    return @divTrunc(a, b);
}
