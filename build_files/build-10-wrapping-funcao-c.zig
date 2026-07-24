const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "meu_programa",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c/teste_wrapping_uma_funcao_c.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true, // Ativa a LibC para compatibilidade com o cURL
        }),
    });

    // 1. Adicionar o caminho dos cabeçalhos (.h) na pasta include/
    exe.root_module.addIncludePath(b.path("include/"));

    // 2. Linkar DIRETAMENTE com a biblioteca de importação dinâmica (.dll.a)
    // Isso evita que o linker tente estaticamente linkar a libcurl.a (o que exigiria zlib, openssl, ssh2, etc.)
    exe.root_module.addObjectFile(b.path("lib/libcurl.dll.a"));

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
