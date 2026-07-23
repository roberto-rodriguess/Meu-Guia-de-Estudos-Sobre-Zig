const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "meu_programa",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c/teste_gerenciamento_de_memoria_entre_fronteiras.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Requerido para stdlib.h e malloc/free
        }),
    });

    b.installArtifact(exe);

    // === Passo 'run' para permitir `zig build run` ===
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Executa o programa");
    run_step.dependOn(&run_cmd.step);
}
