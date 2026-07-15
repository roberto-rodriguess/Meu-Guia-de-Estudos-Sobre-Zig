const std = @import("std");

pub fn main() !void {
    // 1. Inicializa um allocator
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();

    // 2. Obtém a interface Allocator
    const allocator = gpa.allocator();

    // 3. Usa para alocar memória
    const memoria = try allocator.alloc(u8, 100);
    defer allocator.free(memoria);

    const texto = "Olá, Zig!";

    @memcpy(memoria[0..texto.len], texto);

    std.debug.print("{s}\n", .{memoria[0..texto.len]});
}
