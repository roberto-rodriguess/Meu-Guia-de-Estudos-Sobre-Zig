const std = @import("std");
const testing = std.testing;

fn calcularResposta() i32 {
    return 42;
}

test "expectEqual" {
    const esperado: i32 = 42;
    const atual = calcularResposta();

    try testing.expectEqual(esperado, atual);
}
