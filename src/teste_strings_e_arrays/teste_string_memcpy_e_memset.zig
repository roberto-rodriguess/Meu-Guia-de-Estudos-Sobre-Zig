const std = @import("std");

pub fn main() void {
    var origem = [_]u8{ 'a', 'b', 'c', 'd', 'e' };
    var destino: [5]u8 = undefined;

    @memcpy(&destino, &origem);
    std.debug.print("Destino: {s}\n", .{destino});

    @memset(&destino, 'X');
    std.debug.print("Após memset: {s}\n", .{destino});
}
