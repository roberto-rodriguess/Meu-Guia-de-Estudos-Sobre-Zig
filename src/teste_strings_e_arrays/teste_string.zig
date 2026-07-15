const std = @import("std");

pub fn main() void {
    const numeros = [5]i32 {1, 2, 3, 4, 5};

    const letras = [_]u8 {'a', 'b', 'c'};

    const zeros = [_]i32{0} ** 10;

    std.debug.print("Primeiro número: {d}\n", .{numeros[0]});
    std.debug.print("Array de letras: {s}\n", .{letras});
    std.debug.print("Tamanho do array de zeros: {d}\n", .{zeros.len});
}
