const std = @import("std");

const parseInt = std.fmt.parseInt;

pub fn main() void {
    const numero = parseInt(i32, "42M", 10) catch unreachable;

    std.debug.print("{d}\n", .{numero});
}
