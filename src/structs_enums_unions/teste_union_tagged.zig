const std = @import("std");

const Valor = union(enum) {
    inteiro: i32,
    flutuante: f64,
    texto: []const u8,
    nulo,
};

pub fn main() void {
    const v1 = Valor {.inteiro = 42};
    const v2 = Valor {.flutuante = 3.14};
    const v3 = Valor {.texto = "Olá"};
    const v4 = Valor.nulo;

    // Switch seguro — o compilador garante que todos os casos são tratados
    switch (v1) {
        .inteiro => |i| std.debug.print("Inteiro: {d}\n", .{i}),
        .flutuante => |f| std.debug.print("Float: {d}\n", .{f}),
        .texto => |t| std.debug.print("Texto: {s}\n", .{t}),
        .nulo => std.debug.print("Nulo"),
    }

    var valor = Valor {.inteiro = 10};
    switch (valor) {
        .inteiro => |*i| i.* += 1,
        else => {},
    }
}

const TipoValor = enum {
    inteiro,
    flutuante,
    texto,
};

const ValorExplicito = union(TipoValor) {
    inteiro: i32,
    flutuante: f64,
    texto: []const u8,
};
