const std = @import("std");

pub fn main() void {
    const numeros = [_]i32 {10, 20, 30, 40, 50};

    var i: usize = 0;
    while (i < numeros.len) : (i += 1) {
        std.debug.print("numeros[{d}] = {d}\n", .{i, numeros[i]});
    }
}