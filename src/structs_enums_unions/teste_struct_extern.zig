const std = @import("std");

pub fn main() void {
    const CoordenadaC = extern struct {
        x: c_int,
        y: c_int,
    };

    std.debug.print("extern struct: x={d} y={d}", .{CoordenadaC.x, CoordenadaC.y});
}
