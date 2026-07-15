const std = @import("std");

pub fn main() void {
    const pessoa = criarPessoa("Alice", 30);
    std.debug.print("Pessoa - nome: {s} idade: {d}", .{pessoa.nome, pessoa.idade});
}

fn criarPessoa(nome: []const u8, idade: u32) struct {nome: []const u8, idade: u32} {
    return .{.nome = nome, .idade = idade};
}

