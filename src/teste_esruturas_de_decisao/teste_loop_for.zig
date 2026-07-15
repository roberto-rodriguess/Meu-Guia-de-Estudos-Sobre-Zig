const std = @import("std");

pub fn main() void {
    const frutas = [_][]const u8 {"Maçã", "Banana", "Laranja"};

    for (frutas) |fruta| {
        std.debug.print("Frutas: {s}\n", .{fruta});
    }
}
