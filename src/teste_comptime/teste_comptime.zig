const std = @import("std");

fn somar(comptime T: type, a: T, b: T) T {
    return a + b;
}

pub fn main() void {
    // O compilador gera versões especializadas para cada tipo
    const r1 = somar(i32, 10, 20);       // Versão para i32
    const r2 = somar(f64, 3.14, 2.71);   // Versão para f64
    const r3 = somar(u8, 100, 50);       // Versão para u8

    std.debug.print("i32: {}, f64: {d:.2}, u8: {}\n", .{ r1, r2, r3 });
}
