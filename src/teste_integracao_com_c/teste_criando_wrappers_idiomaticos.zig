const std = @import("std");
const c = @cImport({
    @cInclude("mylib.h");
});

const Point = struct {
    raw: *c.Point,

    pub fn new(_x: c_int, _y: c_int) !Point {
        const raw = c.point_create(_x, _y);
        if (raw == null) return error.OutOfMemory;
        return Point{.raw = raw};
    }

    pub fn deinit(self: Point) void {
        c.point_destroy(self.raw);
    }

    pub fn move(self: Point, dx: c_int, dy: c_int) void {
        c.point_move(self.raw, dx, dy);
    }

    pub fn x(self: Point) c_int {
        return self.raw.x;
    }

    pub fn y(self: Point) c_int {
        return self.raw.y;
    }
};

// Uso idiomático em Zig
pub fn main() !void {
    const p = try Point.new(10, 20);
    defer p.deinit();

    p.move(5, -3);
    std.debug.print("Posição: ({}, {})", .{p.x(), p.y()});
}
