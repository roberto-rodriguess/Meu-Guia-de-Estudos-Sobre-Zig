const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "exemplo_libc",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/teste_integracao_com_c/teste_usando_a_libc3.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    b.installArtifact(exe);

    // Adiciona o passo 'run' para você executar com `zig build run`
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    const run_step = b.step("run", "Executar o aplicativo");
    run_step.dependOn(&run_cmd.step);
}
