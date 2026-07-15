const std = @import("std");

const Dado = union {
    inteiro: i32,
    flutuante: f64,
    texto: []const u8,
};

pub fn main() void {
    var dado: Dado = undefined;

    dado.inteiro = 43;
    std.debug.print("Inteiro: {d}\n", .{dado.inteiro});

    dado.flutuante = 3.14;
    std.debug.print("Float: {d}", .{dado.flutuante});
}