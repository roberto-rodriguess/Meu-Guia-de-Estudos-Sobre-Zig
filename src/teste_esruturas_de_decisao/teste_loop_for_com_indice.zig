const std = @import("std");

pub fn main() void {
    const notas = [_]f64 { 8.5, 9.0, 7.5, 10.0 };

    for (notas, 0..) |nota, indice| {
        std.debug.print("Aluno {d}: nota {d:.1}\n", .{indice + 1, nota});
    }
}
