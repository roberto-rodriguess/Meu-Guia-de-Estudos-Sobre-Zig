const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const texto_valido = "Olá, Mundo! 🌍";
    const texto_invalido = "\x80\x81\x82"; // bytes inválidos em UTF-8

    // verificar se é utf8 válido
    const valido = std.unicode.utf8ValidateSlice(texto_valido);
    const invalido = std.unicode.utf8ValidateSlice(texto_invalido);

    print("Texto válido? {s}\n", .{if (valido) "sim" else "não"});
    print("Inválido? {s}\n", .{if (invalido) "sim" else "não"});
}
