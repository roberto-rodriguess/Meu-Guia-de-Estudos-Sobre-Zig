const std = @import("std");

pub fn main() void {
    var i: u8 = 1;

    while (i <= 5) {
        std.debug.print("Contagem: {d}\n", .{i});
        i += 1;
    }
}