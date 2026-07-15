const std = @import("std");
const mat = @import("matematica.zig");
const print = std.debug.print;

pub fn main() void {
    const resultado = mat.somar(3, 6);

    const r = mat.subtrair(3, 1);

    _ = r;

    print("Resultado: {d}\n", .{resultado});
}

const testing = std.testing;

test "teste somar" {
    const resultado = mat.somar(5, 5);

    try testing.expectEqual(resultado, mat.somar(5, 5));
}