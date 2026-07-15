const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();

    try processarRequsicao(gpa.allocator());
}

pub fn processarRequsicao(allocator: std.mem.Allocator) !void {
    // Arena que usa GPA como backend
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit(); // Libera TUDO aqui

    const arena_allocator = arena.allocator();

    // Faça quantas alocações quiser...
    const headers = try arena_allocator.alloc(u8, 1000);
    const body = try arena_allocator.alloc(u8, 1000);
    const response = try arena_allocator.alloc(u8, 500);

    // Não precisa de defer free para cada um!

    @memcpy(headers, "HTTP/1.1 200 OK");
    @memcpy(body, "Conteúdo da resposta...");
    @memcpy(response, "Resposta completa");

    std.debug.print("{s}\n", .{headers});
}