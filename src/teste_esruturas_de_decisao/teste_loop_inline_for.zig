const std = @import("std");

pub fn main() void {
    inline for (0..5) |i| {
        std.debug.print("Iteração {d}\n", .{i});
    }

    const Tipos = .{i32, f64, u8};
    inline for (Tipos) |T| {
        std.debug.print("Tipo: {s}\n", .{@typeName(T)});
    }
}
