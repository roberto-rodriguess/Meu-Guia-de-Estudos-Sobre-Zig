const std = @import("std");

pub fn main() void {
    const maybe_number: ?i32 = 42;

    if (maybe_number) |number| {
        std.debug.print("O número é: {d}\n", .{number});
    } else {
        std.debug.print("Não há número\n", .{});
    }
}
