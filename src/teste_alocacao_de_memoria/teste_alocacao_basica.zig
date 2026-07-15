const std = @import("std");

pub fn main() !void {
    // 1. Inicializa o GBA
    var gba = std.heap.DebugAllocator(.{}){};

    // importante: deinit retorna informação de leaks
    defer {
        const deinit_status = gba.deinit();
        if (deinit_status == .leak) {
            std.debug.print("⚠️ Memory leak detectado!\n", .{});
        }
    }

    const allocator = gba.allocator();

    const nomes = try allocator.alloc([]const u8, 3);
    defer allocator.free(nomes);

    nomes[0] = "Alice";
    nomes[1] = "Bob";
    nomes[2] = "Carol";

    for (nomes) |nome| {
        std.debug.print("{s}\n", .{nome});
    }

}
