const std = @import("std");

pub fn main() void {
    for (0..10) |i| {
        std.debug.print("{d} ", .{i});
    }
    std.debug.print("\n", .{});

    for (5..15) |i| {
        std.debug.print("{d} ", .{i});
    }
    std.debug.print("\n", .{});
}
