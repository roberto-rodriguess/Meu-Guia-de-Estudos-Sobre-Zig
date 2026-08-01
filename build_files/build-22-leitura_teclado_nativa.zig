const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Registra o modulo de teclado
    const kb_module = b.createModule(.{
        .root_source_file = b.path("src/util/keyboard.zig"),
    });

    // Registra o modulo de pausa do sistema
    const sys_module = b.createModule(.{
        .root_source_file = b.path("src/util/system.zig"),
    });

    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_leitura_dados_do_teclado/teste_leitura_teclado_nativa.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // Adiciona os imports de modulo ao executavel
    exe.root_module.addImport("util_keyboard", kb_module);
    exe.root_module.addImport("util_system", sys_module);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Roda o app");
    run_step.dependOn(&run_cmd.step);
}
