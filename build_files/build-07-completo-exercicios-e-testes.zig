// build.zig para compilar, rodar e executar testes

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ============ EXECUTÁVEL PRINCIPAL ============

    // Compila o executável principal
    const exe = b.addExecutable(.{
        .name = "meu-app",
        // No Zig 0.16.0, o arquivo fonte, target e optimize ficam dentro de um root_module
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/exercicios/exercicio.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    b.installArtifact(exe);

    // --- NOVO: CRIANDO O PASSO 'run' ---
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep()); // Garante que compila antes de rodar

    // Permite passar argumentos de linha de comando (ex: zig build run -- arg1 arg2)
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Executa o programa principal");
    run_step.dependOn(&run_cmd.step);

    // ============ TESTES ============

    // Testes unitários
    const unit_tests = b.addTest(.{
        // No Zig 0.16.0, as opções de compilação do teste vão para o root_module
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_testes/teste_padrao_de_organizacao.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    // Testes de integração
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

    const run_integration_tests = b.addRunArtifact(integration_tests);

    // Step "test" roda ambos
    const test_step = b.step("test", "Run all tests");
    test_step.dependOn(&run_unit_tests.step);
    test_step.dependOn(&run_integration_tests.step);

    // Step "test-unit" só para unitários
    const test_unit_step = b.step("test-unit", "Run unit tests only");
    test_unit_step.dependOn(&run_unit_tests.step);

    // Step "test-integration" só para integração
    const test_integration_step = b.step("test-integration", "Run integration tests only");
    test_integration_step.dependOn(&run_integration_tests.step);
}