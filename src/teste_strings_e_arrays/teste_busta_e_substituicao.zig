const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const texto = "A raposa marrom salta sobre o cão preguiçoso";

    // encontrar substring
    const indice = std.mem.indexOf(u8, texto, "marrom");
    if (indice) |idx| {
        print("'marrom' encontrado no índice: {d}\n", .{idx});
    }

    // verificar se contém
    const contem = std.mem.containsAtLeast(u8, texto, 1, "raposa");
    print("Contém 'raposa'? {s}\n", .{if (contem) "sim" else "não"});

    // contar ocorrências
    const contagem = std.mem.count(u8, texto, "o");
    print("O número de 'o's: {d}\n", .{contagem});
}
