const std = @import("std");

pub fn main() void {
    var i: u8 = 1;

    externo: while (i <= 3) : (i += 1) {
        var j: u8 = 1;
        while (j <= 3) : (j += 1) {
            if (i == 2 and j == 2) {
                break :externo;
            }
            std.debug.print("({d}, {d}) ", .{i, j});
        }
        std.debug.print("\n", .{});
    }
    std.debug.print("\nInterrompido no (2,2)\n", .{});
}
