const std = @import("std");
const c = @cImport({
    @cInclude("string.h");
    @cInclude("stdlib.h");
});

pub fn main() !void {
    // Ponteiro C para string (getenv está no stdlib.h)
    // No Windows, USERPROFILE é a variável de ambiente equivalente a HOME
    const c_string_opt = c.getenv("USERPROFILE") orelse c.getenv("HOME");
    if (c_string_opt) |c_string| {
        // Metodo 1: Calcular length com strlen
        const len = c.strlen(c_string);
        const zig_slice: []const u8 = c_string[0..len];
        std.debug.print("Método 1 (strlen): {s}\n", .{zig_slice});
        // Metodo 2: Usar std.mem.span (mais idiomático no Zig)
        const zig_slice2: [:0]const u8 = std.mem.span(c_string);
        // ^ [:0] significa "slice nulo-terminado"
        std.debug.print("Método 2 (std.mem.span): {s}\n", .{zig_slice2});
    } else {
        std.debug.print("Variável de ambiente não encontrada.\n", .{});
    }
}
