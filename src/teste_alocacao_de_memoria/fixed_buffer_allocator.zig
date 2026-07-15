const std = @import("std");

pub fn main() !void {
    try processarDados("Dados importantes");
}

pub fn processarDados(dados: []const u8) !void {
    // Buffer na stack (8KB)
    var buffer: [8192]u8 = undefined;

    // FBA usa esse buffer
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    // Alocações vêm do buffer na stack
    const copia = try allocator.dupe(u8, dados);
    // Não precisa de defer free! Memória é liberada quando função retorna

    std.debug.print("Precessando: {s}\n", .{copia});
}
