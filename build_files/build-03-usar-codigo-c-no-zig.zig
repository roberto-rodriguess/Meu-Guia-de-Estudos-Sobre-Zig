const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/teste_usando_codigo_c_em_zig/teste_usando_codigo_c.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    const exe = b.addExecutable(.{
        .name = "app",
        .root_module = mod,
    });

    const c_mod = b.addTranslateC(.{
        .root_source_file = b.path("src/teste_usando_codigo_c_em_zig/mathutils.h"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    c_mod.addIncludePath(b.path("src/teste_usando_codigo_c_em_zig"));

    mod.addImport("c", c_mod.createModule());

    mod.addCSourceFile(.{
        .file = b.path("src/teste_usando_codigo_c_em_zig/mathutils.c"),
        .flags = &.{ "-std=c11", "-Wall" },
    });

    mod.addIncludePath(b.path("src/teste_usando_codigo_c_em_zig"));

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Executa o programa");
    run_step.dependOn(&run_cmd.step);
}