const std = @import("std");

pub fn main() void {
    const nomes = [_][]const u8 {"Ana", "Bruno", "Carla"};
    const idades = [_]u8 {25, 30, 22};
    
    for (nomes, idades) |nome, idade| {
        std.debug.print("{s} tem {d} anos\n", .{nome, idade});
    }
}
