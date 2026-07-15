const std = @import("std");

pub fn main() void {
    const idade: u8 = 17;

    const status = if (idade >= 18) "maior de idade" else "menor de idade";

    std.debug.print("Status: {s}\n", .{status});

    const categoria = if (idade < 13) "criança"
                                else if (idade < 20) "adolescente"
                                else if (idade < 60) "adulto"
                                else "idoso";

    std.debug.print("Categoria: {s}\n", .{categoria});
}
