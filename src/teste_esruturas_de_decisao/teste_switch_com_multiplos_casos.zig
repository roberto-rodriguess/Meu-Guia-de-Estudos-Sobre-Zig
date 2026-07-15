const std = @import("std");

pub fn main() void {
    std.debug.print("Dia 1: {s}\n", .{tipoDeDia(1)});
    std.debug.print("Dia 4: {s}\n", .{tipoDeDia(4)});
    std.debug.print("Dia inválido: {s}\n", .{tipoDeDia(8)});
}

fn tipoDeDia(dia: u8) []const u8 {
    return switch (dia) {
        1, 7  => "Fim de somana",
        2...6 => "Dia útil",
        else  => "Inválido",
    };
}
