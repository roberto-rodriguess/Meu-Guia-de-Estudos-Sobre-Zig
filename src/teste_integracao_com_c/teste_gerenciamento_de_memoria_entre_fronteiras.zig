//Regras Fundamentais
//Quem aloca, libera: Se C alocou com malloc, libere com free
//Se Zig alocou, Zig libera: Use o mesmo allocator
//Não misture allocators: Não passe memória Zig para free C

const std = @import("std");
const Allocator = std.mem.Allocator;
const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("string.h");
});

// ❌ ERRADO: Misturando allocators
pub fn wrong(allocator: Allocator) !void {
    const ptr: ?*anyopaque = c.malloc(100);
    defer c.free(ptr);

    const zig_mem = try allocator.alloc(u8, 100);
    // // ERRO! zig_mem não foi alocado com malloc
    c.free(zig_mem.ptr);
}

// ✅ CORRETO: Cada lado gerencia sua memória
pub fn correct(allocator: Allocator) !void {
    // Memória C
    const c_mem = c.malloc(100);
    if (c_mem == null) return error.OutOfMemory;
    defer c.free(c_mem); // Libera com free

    // Memória Zig
    const zig_mem = try allocator.alloc(u8, 100);
    defer allocator.free(zig_mem);
}

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Comentado por causar comportamento indefinido (double free/mistura de allocators)
    // _ = try wrong(allocator);

    try correct(allocator);
    std.debug.print("Gerenciamento correto executado com sucesso!\n", .{});
}