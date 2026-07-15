const std = @import("std");

fn encontrarNumero(alvo: i32) ?usize {
    const numeros = [_]i32 {10, 20, 30, 40, 50};

    for (numeros, 0..) |num, index| {
        if (num == alvo) {
            break index;
        }
    }
    return null;
}

pub fn main() void {
    if (encontrarNumero(30)) |index| {
        std.debug.print("Encontrado no índice: {d}\n", .{index});
    } else {
        std.debug.print("Não encotrado\n", .{});
    }
}
