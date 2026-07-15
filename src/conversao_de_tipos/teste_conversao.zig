const std = @import("std");

pub fn main() void {
    const a: i32 = 100;
    const b: f64 = @floatFromInt(a);

    const c: f64 = 3.14;
    const d: i32 = @intFromFloat(c);

    const e: u8 = 255;
    const f: i16 = @intCast(e);

    std.debug.print("{}\n{}\n{}\n", .{b, d, f});

    const grande: u16 = 1000;
    const pequeno_truncado: u8 = @truncate(grande);

    const valor: i32 = 100;
    const convertido: i64 = @intCast(valor);

    std.debug.print("Truncado: {d}\n", .{pequeno_truncado});
    std.debug.print("Convertido: {d}\n", .{convertido});

    const x = @as(u32, 100);
    //const y = @as(f32, 3.14);

    std.debug.print("x: {d} ({s})\n", .{x, @typeName(@TypeOf(x))});
}
