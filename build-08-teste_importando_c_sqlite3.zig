const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "meu_programa",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c/teste_importando_c_sqlite3.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Ativação da LibC requerida pelo SQLite
        }),
    });

    // 1. Adiciona o caminho dos cabeçalhos (.h) da pasta include/
    exe.root_module.addIncludePath(b.path("include/"));

    // 2. Compila o código C do SQLite (sqlite3.c) diretamente no executável
    exe.root_module.addCSourceFile(.{
        .file = b.path("include/lib/sqlite3.c"),
        .flags = &.{ "-std=c99" },
    });

    b.installArtifact(exe);

    // === Passo 'run' para permitir `zig build run` / execução via IDE ===
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Executa o programa");
    run_step.dependOn(&run_cmd.step);
}