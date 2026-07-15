const std = @import("std");

pub fn main() void {
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        if (i % 2 == 0) {
            continue;
        }
        std.debug.print("{d} ", .{i});
    }
    std.debug.print("\n", .{});
}
