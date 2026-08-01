const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Cria o módulo util para compartilhar o util/system.zig com segurança sem violar limites de caminhos de importação
    const util_module = b.createModule(.{
        .root_source_file = b.path("src/util/system.zig"),
    });

    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c_e_c_mais_mais/teste_gerenciamento_de_memoria_atraves_de_fronteiras.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Essencial para gerenciar malloc/free
        }),
    });

    // Registra o módulo util no executável para que possa ser importado com @import("util")
    exe.root_module.addImport("util", util_module);

    // Compila e vincula o arquivo memory.c ao executável
    exe.root_module.addCSourceFile(.{
        .file = b.path("src/teste_integracao_com_c_e_c_mais_mais/memory.c"),
        .flags = &.{ "-std=c99", "-Wall", "-Wextra" },
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Roda o app");
    run_step.dependOn(&run_cmd.step);
}
