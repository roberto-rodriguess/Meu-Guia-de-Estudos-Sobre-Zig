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

pub fn build(b: *std.Build) void {
    // Permite selecionar qual exercício rodar. O padrão é 2 (integração LibC).
    const exec_num = b.option(
        u32, "exercicio",
        "Seleciona o build do exercicio (1-7)"
    ) orelse 9;

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
        else => {
            std.debug.print("Exercício {d} inválido. Escolha de 1 a 7.\n", .{exec_num});
        },
    }
}
