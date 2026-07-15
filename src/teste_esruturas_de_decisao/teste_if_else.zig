const std = @import("std");

pub fn main() void {
    const nota: u8 = 85;

    if (nota > 90) {
        std.debug.print("Aprovado com A!\n", .{});
    } else if (nota >= 80) {
        std.debug.print("Aprovado com B!\n", .{});
    } else if (nota >= 70) {
        std.debug.print("Aprovado com C.\n", .{});
    } else {
        std.debug.print("Reprovado.\n", .{});
    }
}
