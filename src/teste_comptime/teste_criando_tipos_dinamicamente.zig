const std = @import("std");

// Criar um tipo inteiro com N+1 bits
fn inteiroMaior(comptime T: type) type {
    const info = @typeInfo(T).int;
    return @TypeOf(.{
        .int = .{
            .bits = info.bits + 1,
            .signedness = info.signedness,
        },
    });
}

// Criar um tipo inteiro sem sinal a partir de um com sinal
fn semSinal(comptime T: type) type {
    const info = @typeInfo(T).int;
    return @TypeOf(.{
        .int = .{
            .bits = info.bits,
            .signedness = .unsigned,
        }
    });
}

test "manipulação de tipos" {
    // u8 → u9
    try std.testing.expect(inteiroMaior(u8) == u9);

    // i32 → i33
    try std.testing.expect(inteiroMaior(i32) == i33);

    // i64 → u64
    try std.testing.expect(semSinal(i64) == u64);

    // i16 → u16
    try std.testing.expect(semSinal(i16) == u16);
}