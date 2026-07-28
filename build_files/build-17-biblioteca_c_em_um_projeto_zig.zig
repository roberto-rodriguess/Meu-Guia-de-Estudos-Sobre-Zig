const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Compila a biblioteca C (em Zig 0.16.0, addStaticLibrary e addSharedLibrary foram unificadas em addLibrary)
    const lib = b.addLibrary(.{
        .name = "minha-lib",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    lib.root_module.addCSourceFiles(.{
        .files = &.{
            "src/teste_integracao_com_c_e_c_mais_mais/lib.c",
        },
        .flags = &.{
            "-std=c99",
            "-Wall",
            "-Wextra",
        },
    });

    // Adiciona o diretório include/ para compilar a biblioteca C interna
    lib.root_module.addIncludePath(b.path("include/"));

    b.installArtifact(lib);

    // Executável principal
    const exe = b.addExecutable(.{
        .name = "meu-app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c_e_c_mais_mais/teste_biblioteca_c_em_um_projeto_zig.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    // Em Zig 0.16.0, a linkagem de bibliotecas estáticas ou dinâmicas locais é feita no root_module do executável
    exe.root_module.linkLibrary(lib);

    // Adiciona header path para o @cImport do executável
    exe.root_module.addIncludePath(b.path("include/"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Roda o app");
    run_step.dependOn(&run_cmd.step);
}