const std = @import("std");
const testing = std.testing;

fn duplicarString(allocator: std.mem.Allocator, s: []const u8) ![]u8 {
    const resultado = try allocator.alloc(u8, s.len);
    @memcpy(resultado, s);

    return resultado;
}

test "duplicarString não vaza memória" {
    const allocator = testing.allocator;

    const original = "Hello Zig!";
    const copia = try duplicarString(allocator, original);
    defer allocator.free(copia);  // Importante: libera a memória

    try testing.expectEqualStrings(original, copia);
}

// Este teste FALHARIA se esquecêssemos o defer free:
test "detecta vazamento de memória" {
    const allocator = testing.allocator;

    const copia = try duplicarString(allocator, "teste");
    _ = copia;
    // Esquecemos o defer allocator.free(copia)!
    // O teste falhará reportando memory leak
}