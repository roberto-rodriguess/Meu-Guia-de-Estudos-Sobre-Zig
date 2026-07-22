const std = @import("std");

pub fn main(init: std.process.Init) !void {
    // Slice Zig normal
    const zig_string: []const u8 = "Olá, C!";

    // Método 1: Garantir nulo no final (se já for string literal)
    const c_string: [*c]const u8 = "Olá, C!"; // String literals já são nulo-terminadas
    std.debug.print("c_string: {s}\n", .{c_string});

    // Uso
    const allocator = init.gpa;
    const c_str = try toCString(allocator, zig_string);
    std.debug.print("c_str: {s}\n", .{c_str});
    defer allocator.free(c_str);
}

// Método 2: Alocar com nulo para slices dinâmicos
fn toCString(allocator: std.mem.Allocator, slice: []const u8) ![:0]u8 {
    var result = try allocator.allocSentinel(u8, slice.len, 0);
    @memcpy(result[0..slice.len], slice);
    return result;
}
