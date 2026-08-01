const std = @import("std");
const keyboard = @import("util_keyboard"); // Módulo util/keyboard.zig
const system = @import("util_system");     // Módulo util/system.zig

pub fn main() !void {
    std.debug.print("=== Teste de Leitura Nativa de Teclado (Sem Scanf) ===\n", .{});

    // 1. Lê uma string (nome)
    std.debug.print("Digite seu nome: ", .{});
    var nome_buf: [64]u8 = undefined;
    const nome = try keyboard.readLine(&nome_buf);

    // 2. Lê um número inteiro (idade)
    std.debug.print("Digite sua idade: ", .{});
    var idade_buf: [16]u8 = undefined;
    const idade = try keyboard.readInt(i32, &idade_buf);

    // 3. Lê um número decimal (altura)
    std.debug.print("Digite sua altura (ex: 1.75): ", .{});
    var altura_buf: [16]u8 = undefined;
    const altura = try keyboard.readFloat(f64, &altura_buf);

    // Mostra os resultados na tela
    std.debug.print("\n--- Resultados ---\n", .{});
    std.debug.print("Nome  : {s}\n", .{nome});
    std.debug.print("Idade : {d} anos\n", .{idade});
    std.debug.print("Altura: {d:.2} metros\n\n", .{altura});

    // Aguarda o Enter final usando a utilidade pause
    try system.pause();
}
