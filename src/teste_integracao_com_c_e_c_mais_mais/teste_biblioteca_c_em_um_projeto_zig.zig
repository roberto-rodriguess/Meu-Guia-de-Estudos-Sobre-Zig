const std = @import("std");

// Importa o header C automaticamente!
const c = @cImport({
    @cInclude("lib.h");
});

pub fn main() void {
    // Cria pontos usando a biblioteca C compiled estaticamente
    const p1 = c.criar_ponto(10, 20);
    const p2 = c.criar_ponto(13, 24);

    const dist = c.distancia(p1, p2);
    
    std.debug.print("Ponto 1: ({d}, {d})\n", .{p1.x, p1.y});
    std.debug.print("Ponto 2: ({d}, {d})\n", .{p2.x, p2.y});
    std.debug.print("Distância calculada pela Lib C (sqrt): {d}\n\n", .{dist});

    std.debug.print("Distância entre ({d},{d}) e ({d},{d}): {d}\n", .{
        p1.x, p1.y, p2.x, p2.y, dist
    });
}
