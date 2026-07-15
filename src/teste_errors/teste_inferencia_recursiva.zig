const std = @import("std");

fn fibonacci(n: u32) error {OverFlow}!u32 {
    if (n <= 1) return n;

    const a = try fibonacci(n - 1);
    const b = try fibonacci(n - 2);

    return std.math.add(u32, a, b) catch return error.OverFlow;
}

pub fn main() void {
    const f = fibonacci(6000) catch |err| {
        std.debug.print("Erro: {any}\n", .{err});
        return;
    };

    std.debug.print("Fibonacci de {d} é {d}", .{6, f});
}
