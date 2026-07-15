const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const um_byte = try allocator.alloc(u8, 1);
    defer allocator.free(um_byte);

    std.debug.print("Alocado: {any} bytes\n", .{um_byte.len});
}
