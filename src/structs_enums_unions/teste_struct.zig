const std = @import("std");

const Ponto = struct {
    x: f64,
    y: f64,
};

pub fn main() void {
    const p1 = Ponto {
        .x = 10.5,
        .y = 20.3,
    };

    std.debug.print("Ponto 1: ({d}, {d})\n", .{ p1.x, p1.y });

    const p2 = Ponto {.x = 10, .y = 20};

    const x = p2.x;
    const y = p2.y;

    std.debug.print("Ponto 2: ({d}, {d})\n", .{ p2.x, p2.y });
    std.debug.print("Ponto 2 acesso direto: {d} {d}\n", .{x , y});

    const Retangulo = struct {
        origem: Ponto = Ponto {.x = 0, .y = 0},
        largura: f64,
        altura: f64,
    };

    const ret = Retangulo {
        .largura = 100,
        .altura = 50,
    };

    std.debug.print("{} {} {}\n", .{ret.origem, ret.largura, ret.altura});
}
