const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Compila o wrapper C++ (em Zig 0.16.0, addStaticLibrary e addSharedLibrary foram unificadas em addLibrary)
    const cxx_lib = b.addLibrary(.{
        .name = "cxx-wrapper",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true, // Ativa a LibCpp para a compilação C++
        }),
    });

    cxx_lib.root_module.addCSourceFiles(.{
        .files = &.{
            "src/teste_integracao_com_c_e_c_mais_mais/minha-classe.cpp",
            "src/teste_integracao_com_c_e_c_mais_mais/wrapper-c.cpp",
        },
        .flags = &.{
            "-std=c++17",
            "-Wall",
        },
    });

    // Adiciona o diretório include/ para que o Clang encontre 'minha-classe.hpp' ao compilar o wrapper C++
    cxx_lib.root_module.addIncludePath(b.path("include/"));

    b.installArtifact(cxx_lib);

    // Executável Zig
    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c_e_c_mais_mais/integração_com_c_mais_mais.zig"),
            .target = target,
            .optimize = optimize,
            .link_libcpp = true, // Permite que o Zig linke com a C++ Standard Library ao usar o wrapper
        }),
    });

    exe.root_module.linkLibrary(cxx_lib);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Roda o app");
    run_step.dependOn(&run_cmd.step);
}
