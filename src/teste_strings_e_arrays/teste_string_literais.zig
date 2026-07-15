const std = @import("std");

pub fn main() void {
    const mensagem = "Olá, Zig";

    const msg_tipada: []const u8 = "Olá";

    const poema =
        \\Rosas são vermelhas,
        \\Violetas são azuis,
        \\Zig é rápido,
        \\E isso é ótimo!
    ;

    std.debug.print("{s}\n", .{mensagem});
    std.debug.print("{s}\n", .{msg_tipada});
    std.debug.print("{s}\n", .{poema});
}