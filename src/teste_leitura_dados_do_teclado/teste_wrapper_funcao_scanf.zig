const std = @import("std");
const scanner = @import("scanner.zig");

pub fn main() !void {
    std.debug.print("Digite um número decimal: ", .{});
    const numero_decimal = try scanner.readFloat();
    std.debug.print("Número decimal: {}\n", .{numero_decimal});

    std.debug.print("Digite seu nome: ", .{});
    var nome_buf: [20]u8 = undefined;
    const nome = try scanner.readString(&nome_buf);

    std.debug.print("Digite sua idade: ", .{});
    const idade = try scanner.readInt();

    std.debug.print("Olá {s}, você tem {d} anos!\n", .{ nome, idade });
}
