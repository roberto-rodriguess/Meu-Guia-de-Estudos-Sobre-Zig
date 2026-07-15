const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const dados = "maçã,banana,laranja,uva";

    // dividir por vírgula
    var iterador = std.mem.splitScalar(u8, dados, ',');

    print("Frutas:\n", .{});
    while (iterador.next()) |fruta| {
        print("  - {s}\n", .{fruta});
    }

    // split com múltiplos delimitadores
    const texto = "um;dois:três";
    var iter_multi = std.mem.splitAny(u8, texto, ";:");

    print("\nDivisão múltipla:\n", .{});
    while (iter_multi.next()) |parte| {
        print("  [{s}]\n", .{parte});
    }
}
