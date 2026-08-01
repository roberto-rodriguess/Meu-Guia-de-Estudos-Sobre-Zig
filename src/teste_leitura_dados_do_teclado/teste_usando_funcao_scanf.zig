const std = @import("std");

// Declaração externa do scanf. O C exige que o formato seja [*c]const u8
extern "c" fn scanf(format: [*c]const u8, ...) c_int;

pub fn main() void {
    var idade: c_int = 0;

    std.debug.print("Digite sua idade: ", .{});

    // O scanf lê da entrada e grava o resultado diretamente no ponteiro de 'idade'
    // IMPORTANTE: Concatenamos \x00 no fim da string de formato para garantir o padrão C
    _ = scanf("%d\x00", &idade);

    std.debug.print("Sua idade lida: {d}\n", .{idade});
}
