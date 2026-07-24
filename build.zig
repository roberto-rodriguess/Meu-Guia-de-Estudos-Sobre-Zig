const std = @import("std");

const build_01 = @import("build_files/build-01-testes-integracao.zig");
const build_02 = @import("build_files/build-02-integracao-libc.zig");
const build_03 = @import("build_files/build-03-usar-codigo-c-no-zig.zig");
const build_04 = @import("build_files/build-04-exportar-zig-para-c.zig");
const build_05 = @import("build_files/build-05-executar-exercicios.zig");
const build_06 = @import("build_files/build-06-instalar-exercicios.zig");
const build_07 = @import("build_files/build-07-completo-exercicios-e-testes.zig");
const build_08 = @import("build_files/build-08-teste_importando_c_sqlite3.zig");
const build_09 = @import("build_files/build-09-importando_bibliotecas_c_externas.zig");
const build_10 = @import("build_files/build-10-wrapping-funcao-c.zig");
const build_11 = @import("build_files/build-11-trabalhando-com-structs-c.zig");
const build_12 = @import("build_files/build-12-criando_wrappers_idiomaticos.zig");
const build_13 = @import("build_files/build-13-recebendo-callbacks-c.zig");
const build_14 = @import("build_files/build-14-padrao-arena-allocator-c.zig");
const build_15 = @import("build_files/build-15-gerenciamento-memoria-fronteiras.zig");
const build_16 = @import("build_files/build-16-wrapper_idiomatico_de_biblioteca_c.zig");

pub fn build(b: *std.Build) void {
    // Permite selecionar qual exercício rodar. O padrão é o 16.
    const exec_num = b.option(
        u32, "exercicio",
        "Seleciona o build do exercicio (1-16)"
    ) orelse 16;

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
        12 => build_12.build(b),
        13 => build_13.build(b),
        14 => build_14.build(b),
        15 => build_15.build(b),
        16 => build_16.build(b),
        else => {
            std.debug.print("Exercício {d} inválido. Escolha de 1 a 16.\n", .{exec_num});
        },
    }
}
