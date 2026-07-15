const std = @import("std");

const ErroDivisao = error{DivisaoPorZero};

fn divideSegura(a: f64, b: f64) ErroDivisao!f64 {
    if (b == 0) {
        return ErroDivisao.DivisaoPorZero;
    }
    return a / b;
}

pub fn main() void {
    const resultado = divideSegura(10, 0) catch |err| {
        std.debug.print("Erro: {}\n", .{err});
        return;
    };

    std.debug.print("Resultado: {d}\n", .{resultado});
}