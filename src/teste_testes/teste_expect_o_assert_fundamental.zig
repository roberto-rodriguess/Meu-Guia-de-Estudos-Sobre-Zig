const std = @import("std");
const testing = std.testing;

fn soma(a: i32, b: i32) i32 {
    return a + b;
}

test "expect básico" {
    const resultado = soma(2, 3);
    try testing.expect(resultado == 5);
}
