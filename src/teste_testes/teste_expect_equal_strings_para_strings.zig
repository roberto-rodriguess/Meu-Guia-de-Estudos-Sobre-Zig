const std = @import("std");
const testing = std.testing;

test "comparação de strigs" {
    const nome: *const [7:0]u8 = "ZigLang";
    try testing.expectEqualStrings("ZigLang", nome);
}
