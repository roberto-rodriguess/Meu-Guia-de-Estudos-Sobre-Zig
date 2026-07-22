const std = @import("std");

const build_01 = @import("build-01-testes-integracao.zig");
const build_02 = @import("build-02-integracao-libc.zig");
const build_03 = @import("build-03-usar-codigo-c-no-zig.zig");
const build_04 = @import("build-04-exportar-zig-para-c.zig");
const build_05 = @import("build-05-executar-exercicios.zig");
const build_06 = @import("build-06-instalar-exercicios.zig");
const build_07 = @import("build-07-completo-exercicios-e-testes.zig");
const build_08 = @import("build-08-teste_importando_c_sqlite3.zig");
const build_09 = @import("build-09-importando_bibliotecas_c_externas.zig");
const build_10 = @import("build-10-wrapping-funcao-c.zig");
const build_11 = @import("build-11-trabalhando-com-structs-c.zig");

pub fn build(b: *std.Build) void {
    // Permite selecionar qual exercício rodar. O padrão é o 11.
    const exec_num = b.option(
        u32, "exercicio",
        "Seleciona o build do exercicio (1-11)"
    ) orelse 11;

    switch (exec_num) {
        1 => build_01.build(b),
        2 => build_02.build(b),
        3 => build_03.build(b),
        4 => build_04.build(b),
        5 => build_05.build(b),
        6 => build_06.build(b),
        7 => build_07.build(b),
        8 => build_08.build(b),
        9 => build_09.build(b),
        10 => build_10.build(b),
        11 => build_11.build(b),
        else => {
            std.debug.print("Exercício {d} inválido. Escolha de 1 a 11.\n", .{exec_num});
        },
    }
}
