// build.zig para execução de testes

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Modificado para o padrão do Zig 0.16.0+
    const integration_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/integration_tests.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // Criamos o módulo para o seu banco de dados
    const src_mod = b.createModule(.{
        .root_source_file = b.path("src/teste_testes/teste_database.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Adiciona o módulo ao teste
    integration_tests.root_module.addImport("database", src_mod);

    // Cria o comando para rodar
    const run_integration_tests = b.addRunArtifact(integration_tests);

    const test_step = b.step("test", "Rodar todos os testes");
    test_step.dependOn(&run_integration_tests.step);

}