const std = @import("std");

pub fn main() void {
    var i: u8 = 1;

    while (true) {
        if (i > 10) {
            break;
        }
        std.debug.print("{d} ", .{i});
        i += 1;
    }
    std.debug.print("\nFim!\n", .{});
}
