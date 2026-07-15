const std = @import("std");

pub fn main() void {
    const talvezNumero: ?i32 = 42;
    const talvezNulo: ?i32 = null;

    if (talvezNumero) |numero| {
        std.debug.print("Valor: {d}\n", .{numero});
    } else {
        std.debug.print("É nulo\n");
    }

    if (talvezNulo) |nulo| {
        std.debug.print("Valor: {d}\n", .{nulo});
    } else {
        std.debug.print("É nulo\n", .{});
    }
}
