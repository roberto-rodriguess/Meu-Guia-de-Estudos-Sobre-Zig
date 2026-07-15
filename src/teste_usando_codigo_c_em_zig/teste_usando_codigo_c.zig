const c = @import("c");
const std = @import("std");

pub fn main() void {
    const resultado = c.soma(10, 10);
    std.debug.print("10 + 20 = {d}\n", .{resultado});

    const raiz = c.raiz_quadrada(144.0);
    std.debug.print("sqrt(144) = {d}\n", .{raiz});
}
