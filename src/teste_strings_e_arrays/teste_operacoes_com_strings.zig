const std = @import("std");
const print = std.debug.print;
const concat = std.mem.concat;

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const part1 = "Olá";
    const part2 = "Mundo";

    // aloca memória para a string concatenada
    const resultado = try concat(allocator, u8, &.{part1, ", ", part2, "!"});
    defer allocator.free(resultado);

    print("{s}\n", .{resultado});
}
