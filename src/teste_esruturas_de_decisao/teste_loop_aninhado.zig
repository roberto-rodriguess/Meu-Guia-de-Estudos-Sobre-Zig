const std = @import("std");

pub fn main() void {
    var i: u8 = 1;

    while (i <= 3) : (i += 1) {
        var j: u8 = 1;
        while (j <= 3) : (j += 1) {
            std.debug.print("({d}, {d}) ", .{i, j});
        }
        std.debug.print("\n", .{});
    }
}
