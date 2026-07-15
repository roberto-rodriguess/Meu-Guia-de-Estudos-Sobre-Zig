const std = @import("std");

pub fn main() !void {
    const c_allocator = std.heap.c_allocator;

    const memoria = try c_allocator.alloc(u8, 100);
    defer c_allocator.free(memoria);
}