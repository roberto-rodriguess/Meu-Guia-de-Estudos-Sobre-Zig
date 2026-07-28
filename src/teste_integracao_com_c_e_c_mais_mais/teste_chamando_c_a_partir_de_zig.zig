const std = @import("std");

// Declara funções da libc
extern "c" fn printf(format: [*c]const u8, ...) c_int;
extern "c" fn strlen(s: [*c]const u8) usize;
extern "c" fn malloc(size: usize) ?*anyopaque;
extern "c" fn free(ptr: ?*anyopaque) void;

pub fn main() void {
    // Usando printf da libc
    _ = printf("Olá de C!\n");

    // Usando strlen
    const msg = "Zig é incrível";
    const len = strlen(msg);
    std.debug.print("Tamanho: {d}\n", .{len});
}
