const std = @import("std");

const Erro = error {Falha};

fn demonstrarOrdem() !void {
    errdefer std.debug.print("errdefer 1\n", .{});
    errdefer std.debug.print("errdefer 2\n", .{});
    defer std.debug.print("defer 1\n", .{});
    defer std.debug.print("defer 2\n", .{});

    return Erro.Falha;
}

pub fn main() !void {
    // Regra: errdefers executam na ordem inversa (LIFO), antes de retornar o erro.
    try demonstrarOrdem();
}
