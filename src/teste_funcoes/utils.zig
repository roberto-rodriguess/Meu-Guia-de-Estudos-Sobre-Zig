const std = @import("std");

pub fn printValue(value: anytype) void {
    std.debug.print("Valor: {}\n", .{value});
}
