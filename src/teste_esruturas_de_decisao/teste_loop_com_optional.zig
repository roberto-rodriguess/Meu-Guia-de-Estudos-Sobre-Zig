const std = @import("std");

pub fn main() void {
    const valores = [_]?i32 {10, null, 30, null, 50};

    for (valores) |maybe_valor| {
        if (maybe_valor) |valor| {
            std.debug.print("Valor: {d}\n", .{valor});
        } else {
            std.debug.print("Valor ausente\n", .{});
        }
    }
}
