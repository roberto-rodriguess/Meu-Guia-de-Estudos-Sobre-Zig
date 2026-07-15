const std = @import("std");

pub fn main() void {
    // String literal C (null-terminated)
    const c_str: [:0]const u8 = "Hello";

    // Converter para ponteiro C
    const c_ptr: [*c]const u8 = c_str;

    const slice: []const u8 = std.mem.span(c_ptr);

    std.debug.print("Slice: {s}\n", .{slice});
    std.debug.print("Tamanho: {d}\n", .{slice.len});
}
