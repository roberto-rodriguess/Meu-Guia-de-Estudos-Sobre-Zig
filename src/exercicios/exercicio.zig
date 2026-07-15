const std = @import("std");

pub fn main() void {
    const idade: u8 = 25;

    const populacao_mundial: u64 = 8_000_000_000;

    const timestamp: i64 = 1_707_678_440;

    std.debug.print("Idade: {d}\n", .{idade});
    std.debug.print("População: {d} pessoas\n", .{populacao_mundial});
    std.debug.print("Timestamp: {d}\n", .{timestamp});

    const tipoArbitrario: u54 = 1000;
    printValue(tipoArbitrario);

    const tipoArbitrario2: i2 = 1;
    printValue(tipoArbitrario2);

    const tipoPontoFlutuante: f16 = 4.2;
    printValue(tipoPontoFlutuante);

    const nota_cientifica: f64 = 1.5e10;
    printValue(nota_cientifica);

    const ativo: bool = false;
    printValue(ativo);

    const a: bool = false;
    const b: bool = true;

    const e_logico = a and b;
    printValue(e_logico);

    const ou_logico = a or b;
    printValue(ou_logico);

    const nao_logico = !a;
    printValue(nao_logico);

    const letra_ascii: u8 = 'A';
    printValue(letra_ascii);

    const emogi: u21 = '🎉';
    printValue(emogi);

    const qualquer_unicode: u32 = '中';
    printValue(qualquer_unicode);

}

pub fn printValue(value: anytype) void {
    std.debug.print("Valor: {}\n", .{value});
}
