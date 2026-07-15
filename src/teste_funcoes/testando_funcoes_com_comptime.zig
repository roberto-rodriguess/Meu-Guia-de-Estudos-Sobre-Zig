const std = @import("std");

fn maior(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

pub fn main() void {
    const max_int = maior(i32, 10, 20);
    const max_float = maior(f64, 3.14, 2.71);
    const max_string = maior([]const u8, "A", "B");

    std.debug.print("Maior inteiro: {d}\n", .{max_int});
    std.debug.print("Maior float: {d}\n", .{max_float});
    std.debug.print("Maior string: {s}\n", .{max_string});
}
