const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    // string literal:
    const literal = "Zig";

    // convertendo pra slice
    const slice: []const u8 = literal;

    print("Tamanho do literal: {d}\n", .{literal.len});
    print("Tamanho do slice: {d}\n", .{slice.len});
}