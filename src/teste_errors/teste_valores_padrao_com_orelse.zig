const std = @import("std");

pub fn main() void {
    const talvezValor: ?i32 = null;
    std.debug.print("{?}\n", .{talvezValor});

    // orelse com valor
    const valor1 = talvezValor orelse 0;

    std.debug.print("{d}\n", .{valor1});

    // orelse com bloco
    const valor2 = talvezValor orelse blk: {
        std.debug.print("Usando padão\n", .{});
        break :blk 0;
    };

    std.debug.print("{d}\n", .{valor2});

    // orelse com retorno
    const valor3 = talvezValor orelse error.ValorNulo;

    std.debug.print("{any}\n", .{valor3});
}