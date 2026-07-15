const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const a = "Zig";
    const b = "Zig";
    const c = "Rust";

    // comparação lexicográfica
    const iguais = std.mem.eql(u8, a, b);
    const diferentes = std.mem.eql(u8, a, c);

    print("a == b ? {s}\n", .{if (iguais) "sim" else "não"});
    print("a == c ? {s}\n", .{if (diferentes) "sim" else "não"});

    // ordem lexicográfica
    const ordem = std.mem.order(u8, a, c);
    print("ordem(a, c) = {any}\n", .{ordem}); // .lt (menor que)
}
