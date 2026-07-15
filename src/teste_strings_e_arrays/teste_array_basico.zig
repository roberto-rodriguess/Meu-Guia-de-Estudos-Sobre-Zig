const std = @import("std");

pub fn main() void {
    const arr = [_]i32 {1, 2, 3, 4, 5};

    processar(&arr);
}

fn processar(dados: []const i32) void {
    for (dados) |valor| {
        std.debug.print("{} ", .{valor});
    }
}
