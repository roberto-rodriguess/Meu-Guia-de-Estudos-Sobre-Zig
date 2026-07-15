const std = @import("std");

// Error set é inferido de todas as iterações possíveis
fn processarLista(itens: []const i32) !void {
    for (itens) |item| {
        try processar(item); // erro pode vir de qualquer iteração
    }
}

fn processar(item: i32) !void {
    std.debug.print("{d} ", .{item});
}

pub fn main() !void {
    try processarLista(&[_]i32{ 10, 20, 30, 40, 50 });
}
