const std = @import("std");

pub fn main() void {
    const nota: u8 = 85;
    std.debug.print("Conceito: {s}\n", .{conceitoDaNota(nota)});
}

fn conceitoDaNota(nota: u8) []const u8 {
    return switch (nota) {
        90...100 => "A - Excelente",
        80...89  => "B - Bom",
        70...79  => "C - Satisfatório",
        60...69  => "D - Insuficiente",
        0...59   => "F - Reprovado",
        else     => "Nota inválida"
    };
}
