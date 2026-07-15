const std = @import("std");
const testing = std.testing;

const ErroDivisao = error {DivisaoPorZero};

fn divide(a: i32, b: i32) !i32 {
    if (b == 0) return ErroDivisao.DivisaoPorZero;

    return @divTrunc(a, b);
}

test "expectError" {
    // Testa que a função RETORNA o erro esperado
    try testing.expectError(
        ErroDivisao.DivisaoPorZero,
        divide(10, 0)
    );

}

test "expectEqual" {
    // Testa que a função NÃO retorna erro
    const resultado = divide(10, 2);
    try testing.expectEqual(5, resultado);
}
