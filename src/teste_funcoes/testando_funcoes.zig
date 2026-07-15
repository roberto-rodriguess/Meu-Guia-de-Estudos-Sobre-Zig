const std = @import("std");

pub fn main() !void {
    const resultado = divideComResto(17, 5);

    std.debug.print("17 / 5 = {d} (resto {d})\n", .{
        resultado.quociente,
        resultado.resto,
    });
}

fn divideComResto(dividendo: i32, divisor: i32) struct {quociente: i32, resto: i32} {
    return .{
        .quociente = @divTrunc(dividendo, divisor),
        .resto = @rem(dividendo, divisor),
    };
}
