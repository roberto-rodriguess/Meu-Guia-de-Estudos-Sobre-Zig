const std = @import("std");

pub fn main() void {
    // Tipos podem ser armazenados em constantes
    const MeuTipo = i32;
    var x: MeuTipo = 42;
    x += 1;

    // Tipos podem ser escolhidos condicionalmente
    const numero = if (@sizeOf(usize) >= 8) i64 else i32;
    const valor: numero = 1000;

    std.debug.print("Tamanho de Numero: {} bytes\n", .{@sizeOf(numero)});
    std.debug.print("Valor: {}\n", .{valor});

    // Branching sobre tipos em comptime
    const tipo_escolhido = comptime blk: {
        const arquitetura = @import("builtin").cpu.arch;
        break :blk switch (arquitetura) {
            .x86_64 => f64,
            .aarch64 => f64,
            else => f32,
        };
    };

    std.debug.print("Tipo de float para esta arquitetura: {any}\n", .{@typeName(tipo_escolhido)});
}