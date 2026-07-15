const std = @import("std");
const testing = std.testing;

// ============ IMPLEMENTAÇÃO ============

pub fn fatorial(n: u32) u64 {
    if (n < 1) return 1;

    return n * fatorial(n - 1);
}

pub fn ehPrimo(n: u32) bool {
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    var i: u32 = 3;
    while (i * i < n) : (i += 2) {
        if (n % i == 0) return false;
    }
    return true;
}

// ============ TESTES ============

test "fatorial de números pequenos" {
    try testing.expectEqual(1, fatorial(0));
    try testing.expectEqual(1, fatorial(1));
    try testing.expectEqual(2, fatorial(2));
    try testing.expectEqual(6, fatorial(3));
    try testing.expectEqual(24, fatorial(4));
}

test "fatorial de número maior" {
    try testing.expectEqual(120, fatorial(5));
    try testing.expectEqual(3628800, fatorial(10));
}

test "verificação de primos" {
    try testing.expect(!ehPrimo(0));
    try testing.expect(!ehPrimo(1));
    try testing.expect(ehPrimo(2));
    try testing.expect(ehPrimo(3));
    try testing.expect(!ehPrimo(4));
    try testing.expect(ehPrimo(17));
    try testing.expect(!ehPrimo(18));
}