const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exercicios = [_][]const u8{
        "operacoes_com_arrays",
        "resultado_operacao",
    };

    for (exercicios) |ex_name| {
        const path = b.fmt("src/exercicios/{s}.zig", .{ex_name});

        const mod = b.createModule(.{
            .root_source_file = b.path(path),
            .target = target,
            .optimize = optimize,
        });

        const exe = b.addExecutable(.{
            .name = ex_name,
            .root_module = mod,
        });

        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);

        const run_step = b.step(ex_name, b.fmt("Executa o exercício {s}", .{ex_name}));
        run_step.dependOn(&run_cmd.step);
    }
}