const std = @import("std");

const ErroValidacao = error {
    NomeVazio,
    EmailInvalido,
    SenhaCurta,
};

const ErrosValidacao = struct {
    erros: [3]?ErroValidacao,
    count: usize,

    pub fn novo() ErrosValidacao {
        return .{
            .erros = .{null, null, null},
            .count = 0,
        };
    }

    pub fn adicionar(self: *ErrosValidacao, erro: ErroValidacao) void {
        if (self.count < self.erros.len) {
            self.erros[self.count] = erro;
            self.count += 1;
        }
    }
};

fn validarUsuario(nome: []const u8, email: []const u8, senha: []const u8) ErrosValidacao {
    var erros = ErrosValidacao.novo();

    if (nome.len == 0) erros.adicionar(ErroValidacao.NomeVazio);
    if (!contemArroba(email)) erros.adicionar(ErroValidacao.EmailInvalido);
    if (senha.len < 8) erros.adicionar(ErroValidacao.SenhaCurta);

    return erros;
}

fn contemArroba(s: []const u8) bool {
    for (s) |c| {
        if (c == '@') return true;
    }
    return false;
}

const Usuario = struct {
    nome: []const u8,
    email: []const u8,
    senha: []const u8,

    pub fn novo(nome: []const u8, email: []const u8, senha: []const u8) Usuario {
        return .{
            .nome = nome,
            .email = email,
            .senha = senha,
        };
    }
};

pub fn main() void {
    const usuario = Usuario.novo("", "emailusuario1gmail.com", "senha");

    const erros = validarUsuario(usuario.nome, usuario.email, usuario.senha);

    for (erros.erros[0..erros.count]) |erro| {
        if (erro) |e| {
            std.debug.print("Erro: {}\n", .{e});
        }
    }
}
