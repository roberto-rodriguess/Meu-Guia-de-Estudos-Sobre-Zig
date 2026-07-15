const std = @import("std");

// anytype permite aceitar qualquer tipo
fn dobrar(valor: anytype) @TypeOf(valor) {
    return valor + valor;
}

fn imprimir(valor: anytype) void {
    const T = @TypeOf(valor);
    switch (@typeInfo(T)) {
        .int, .comptime_int => std.debug.print("Inteiro: {}\n", .{valor}),
        .float, .comptime_float => std.debug.print("Float: {d:.4}\n", .{valor}),
        .pointer => |ptr_info| {
            if (ptr_info.size == .slice and ptr_info.child == u8) {
                std.debug.print("String: {s}\n", .{valor});
            } else {
                std.debug.print("Ponteiro: {*}\n", .{valor});
            }
        },
        else => std.debug.print("Tipo: {}\n", .{@typeName(T)}),
    }
}

pub fn main() void {
    std.debug.print("{}\n", .{dobrar(@as(i32, 21))}); // 42
    std.debug.print("{d}\n", .{dobrar(@as(f64, 1.5))}); // 3.0

    imprimir(@as(i32, 42));
    imprimir(@as(f64, 3.14));
    imprimir("Olá Zig!");
}