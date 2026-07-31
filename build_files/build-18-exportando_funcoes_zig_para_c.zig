const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Compila como biblioteca dinâmica (em Zig 0.16.0, addStaticLibrary e addSharedLibrary foram unificadas em addLibrary)
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
}
