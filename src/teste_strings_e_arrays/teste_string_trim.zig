const std = @import("std");

pub fn main() void {
    const texto = "   espaços extras   ";

    // remover espaços extras do início e do fim
    const trimado = std.mem.trim(u8, texto, " ");
    std.debug.print("'{s}'\n", .{trimado});

    // remover whitespace (espaço, tab, newline)
    const whitespace = "\t\n texto \n\t";
    const limpo = std.mem.trim(u8, whitespace, &std.ascii.whitespace);
    std.debug.print("'{s}'\n", .{limpo}); // "texto"
}
