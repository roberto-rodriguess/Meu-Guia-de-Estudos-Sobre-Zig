const std = @import("std");

pub fn main() void {
    const dia_da_semana: u8 = 3;

    const nome_dia = switch (dia_da_semana) {
        1 => "Domingo",
        2 => "Segunda-feira",
        3 => "Terca-feira",
        4 => "Quinta-feira",
        5 => "Sexta-feira",
        6 => "Sábado",
        else => "Dia inválido"
    };

    std.debug.print("Hoje é: {s}\n", .{nome_dia});
}