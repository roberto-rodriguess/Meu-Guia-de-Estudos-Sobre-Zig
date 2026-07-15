const std = @import("std");

// Importando a Libc diretamente
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("string.h");
    @cInclude("math.h");
    @cInclude("time.h"); // Adicionado para garantir o c.time
});

pub fn main() !void {
    _ = c.printf("Digite um número: ");
    const n: ?[]c_char = null;
    _ = c.scanf("%d", &n);
}
