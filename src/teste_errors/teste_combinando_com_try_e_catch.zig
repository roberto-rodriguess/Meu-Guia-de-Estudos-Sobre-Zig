const std = @import("std");

const Usuario = struct {
    id: u64,
    nome: []const u8,
    email: ?[]const u8, //opcional
};

fn enviarEmail(usuario: Usuario) !void {
    // orelse para optional
    const email = usuario.email orelse {
        std.debug.print("Usuário sem email\n", .{});
        return;
    };

    // try para error union
    try enviarPara(email);
}

fn enviarPara(email: []const u8) !void {
    // _ = email;
    std.debug.print("Enviando email para {s}...", .{email});
}

pub fn main() void {
    const usuario = Usuario {
        .id = 1111,
        .nome = "A",
        .email = "teste.com",
    };

    try enviarEmail(usuario);
}