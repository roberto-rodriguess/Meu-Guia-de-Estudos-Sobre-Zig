const std = @import("std");

const c = @cImport({
    @cInclude("worker2.h");
});

pub fn processWithC(allocator: std.mem.Allocator) !void {
    // Criar arena
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();

    // Alocar tudo que C precisa na arena
    const buf1 = try arena_allocator.alloc(u8, 100);
    const buf2 = try arena_allocator.alloc(u8, 200);
    // Correção: dupeZ duplica e garante terminador nulo \0 para FFI com o C
    const buf3 = try arena_allocator.dupeZ(u8, "dados");

    // Passar para C
    c.process_data(buf1.ptr, buf2.ptr, buf3.ptr);

    // Exibir resultados escritos pelo C
    std.debug.print("[Zig] Buf1 modificado: {s}\n", .{std.mem.sliceTo(buf1, 0)});
    std.debug.print("[Zig] Buf2 modificado: {s}\n", .{std.mem.sliceTo(buf2, 0)});
    std.debug.print("[Zig] Buf3 modificado: {s}\n", .{std.mem.sliceTo(buf3, 0)});
}

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    try processWithC(allocator);
}
