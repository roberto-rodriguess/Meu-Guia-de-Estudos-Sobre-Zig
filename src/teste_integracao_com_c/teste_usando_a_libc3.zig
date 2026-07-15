const std = @import("std");

// Importando a Libc diretamente
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
});

pub fn main() !void {
    const ptr_c = c.malloc(100 * @sizeOf(i32));
    if (ptr_c == null) return error.OutOfMemory;
    defer c.free(ptr_c);

    const slice: []i32 = @as([*]i32, @ptrCast(ptr_c))[0..100];
    slice[0] = 42; // Agora temos bounds checking!
    slice[50] = 100;

    for (slice) |n| {
        c.printf("%d", n);
    }

}
