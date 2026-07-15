const std = @import("std");
const fun = @import("utils.zig");

pub fn main() !void {
    dizOla();

    const resultado = soma(2, 8);
    fun.printValue(resultado);

    apresentar("rob", 20);
}

fn dizOla() void {
    std.debug.print("Olá!\n", .{});
}

fn soma(a: i32, b: i32) i32 {
    return a + b;
}

fn apresentar(nome: []const u8, idade: u8) void {
    std.debug.print("{s} tem {d} anos\n", .{nome, idade});
}
