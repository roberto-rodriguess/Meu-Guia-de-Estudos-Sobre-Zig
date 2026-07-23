const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "meu_programa",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c/teste_criando_wrappers_idiomaticos.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Ativa a LibC
        }),
    });

    // 1. Adiciona o caminho do cabeçalho mylib.h (localizado na pasta include/)
    exe.root_module.addIncludePath(b.path("include/"));

    // 2. Compila a implementação C da nossa biblioteca junto com o projeto
    exe.root_module.addCSourceFile(.{
        .file = b.path("src/teste_integracao_com_c/mylib.c"),
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
