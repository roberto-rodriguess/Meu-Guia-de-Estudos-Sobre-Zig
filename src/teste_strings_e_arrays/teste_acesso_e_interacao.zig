const std = @import("std");

pub fn main() void {
    const frutas = [_][]const u8 {"maçã", "banana", "laranja"};

    std.debug.print("Primeira fruta: {s}\n", .{frutas[0]});
    
    for (frutas) |fruta| {
        std.debug.print("Fruta: {s}\n", .{fruta});
    }

    for (frutas, 0..) |fruta, i| {
        std.debug.print("{d}. {s}\n", .{i + 1, fruta});
    }

    const matriz = [3][3]i32 {
        .{1, 2, 3},
        .{4, 5, 6},
        .{7, 8, 9},
    };

    const elemento = matriz[1][2];

    std.debug.print("{d}", .{elemento});
}
