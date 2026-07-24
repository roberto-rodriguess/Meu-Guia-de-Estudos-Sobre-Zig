const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Biblioteca Zig compilada como biblioteca estática
    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "mathlib",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_exportando_funcoes_pra_c/teste_export.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // Executável C que usa a biblioteca Zig
    const exe = b.addExecutable(.{
        .name = "programa_c",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });

    exe.root_module.addCSourceFile(.{
        .file = b.path("src/teste_exportando_funcoes_pra_c/main.c")
    });

    exe.root_module.linkLibrary(lib);
    exe.root_module.link_libc = true;

    b.installArtifact(exe);

    // Configuração do comando 'zig build run'
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Executa o programa C");
    run_step.dependOn(&run_cmd.step);
}
