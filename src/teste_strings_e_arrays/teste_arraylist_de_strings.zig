const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    var nomes = std.ArrayList([]const u8).empty;
    defer {
        // libera cada string individualmente
        for (nomes.items) |nome| {
            allocator.free(nome);
        }
        nomes.deinit(allocator);
    }

    const nome1 = try allocator.dupe(u8, "Alice");
    const nome2 = try allocator.dupe(u8, "Bob");

    try nomes.append(allocator, nome1);
    try nomes.append(allocator, nome2);

    for (nomes.items) |nome| {
        std.debug.print("Olá, {s}!\n", .{nome});
    }
}
