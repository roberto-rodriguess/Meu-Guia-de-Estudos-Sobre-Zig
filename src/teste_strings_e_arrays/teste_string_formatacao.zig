const std = @import("std");

pub fn main() !void {
    var gba = std.heap.DebugAllocator(.{}){};
    defer _ = gba.deinit();
    const allocator = gba.allocator();

    const nome = "Zig";
    const versao = "0.16.0";

    // formatar string
    const mensagem = try std.fmt.allocPrint(allocator, "{s} versão {s}", .{nome, versao});
    defer allocator.free(mensagem);

    std.debug.print("{s}\n", .{mensagem});

    // formatação com largura
    const tabela = try std.fmt.allocPrint(allocator, "| {s: <10} | {s: >10} | ", .{"Linguagem", "Performance"});
    defer allocator.free(tabela);

    std.debug.print("{s}\n", .{tabela});
}
