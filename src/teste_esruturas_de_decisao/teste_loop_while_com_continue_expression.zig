const std = @import("std");

pub fn main() void {
    var i: u8 = 1;

    while (i <= 5) : (i += 1) {
        std.debug.print("Contagem: {d}\n", .{i});
    }
}
