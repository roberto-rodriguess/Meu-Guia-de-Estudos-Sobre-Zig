const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 1. Compila a biblioteca dinâmica em Zig (DLL)
    const lib = b.addLibrary(.{
        .name = "ziglib",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c_e_c_mais_mais/teste_exportando_funcoes_zig_para_c.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(lib);

    // 2. Compila o executável C a partir de main.c
    const exe = b.addExecutable(.{
        .name = "programa_c",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Ativa a LibC
        }),
    });

    exe.root_module.addCSourceFile(.{
        .file = b.path("src/teste_integracao_com_c_e_c_mais_mais/main.c"),
        .flags = &.{ "-std=c99" },
    });

    // Linka a biblioteca dinâmica Zig no executável C
    exe.root_module.linkLibrary(lib);

    // Adiciona o diretório include/ onde o cabeçalho 'ziglib.h' está localizado
    exe.root_module.addIncludePath(b.path("include/"));

    b.installArtifact(exe);

    // === Passo 'run' para permitir `zig build run` ===
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Executa o programa C");
    run_step.dependOn(&run_cmd.step);
}
