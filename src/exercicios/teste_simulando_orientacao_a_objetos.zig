const std = @import("std");

const Usuario = struct {
    nome: []const u8,
    idade: u32,

    const This = @This();

    pub fn new(nome: []const u8, idade: u32) This {
        return .{
            .nome = nome,
            .idade = idade,
        };
    }

    pub fn setNome(this: *This, nome: []const u8) void {
        // Apenas reatribui o slice de string para o novo literal
        this.nome = nome;
    }

    pub fn getNome(this: This) []const u8 {
        return this.nome;
    }

    pub fn setIdade(this: *This, idade: u32) void {
        // Exige ponteiro *This para poder modificar o valor
        this.idade = idade;
    }

    pub fn getIdade(this: This) u32 {
        return this.idade;
    }
};

pub fn main() !void {
    // Declarado como 'var' para permitir mutação do objeto
    var usuario = Usuario.new("usuário1", 20);

    std.debug.print("Usuário: {s} - {d}\n", .{usuario.nome, usuario.idade});

    usuario.setNome("novo nome");
    // Adicionado marcador {s} para formatar e imprimir a string
    std.debug.print("Novo nome: {s}\n", .{usuario.nome});
}
