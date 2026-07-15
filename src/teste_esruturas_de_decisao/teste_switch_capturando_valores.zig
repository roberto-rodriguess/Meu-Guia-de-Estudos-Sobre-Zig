const std = @import("std");

const Erro = error{ NotFound, PermissionDenied, OutOfMemory };

fn tratarErro(err: Erro) []const u8 {
    return switch (err) {
        error.NotFound => "Recurso não encontrado",
        error.PermissionDenied => "Acesso negado",
        error.OutOfMemory => "Memória insuficiente",
    };
}

pub fn main() void {
    const resultado: Erro!i32 = error.NotFound;

    switch (resultado) {
        error.NotFound => std.debug.print("Não encontrado!\n", .{}),
        error.PermissionDenied => std.debug.print("Sem permissão!\n", .{}),
        else => |e| std.debug.print("Erro: {}\n", .{e}),
    }
}
