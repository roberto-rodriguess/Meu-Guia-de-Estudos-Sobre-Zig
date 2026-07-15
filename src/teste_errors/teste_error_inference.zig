const std = @import("std");

// O compilador infere: error{DivisaoPorZero}!i32
fn dividir(a: i32, b: i32) !i32 {
    if (b == 0) return error.DivisaoPorZero;
    return @divTrunc(a, b);
}

// Error set combinado automaticamente
fn operacaoComplexa() !void {
    const x = try dividir(10, 2); // pode dar DivisaoPorZero
    const y = try raizQuadrada(x);          // pode dar RaizNegativa

    std.debug.print("Divisão de {d} por {d} = {d}\n", .{10, 2, x});
    std.debug.print("Raiz quadrada: de {d} = {d}", .{x ,y});
}

fn raizQuadrada(x: i32) !i32 {
    if (x < 0) return error.RaizNegativa;
    return std.math.sqrt(@as(u32, @intCast(x)));
}

pub fn main() !void {
    try operacaoComplexa();
}
