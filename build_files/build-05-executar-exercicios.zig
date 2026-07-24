const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Lista com o nome de todos os seus exercícios
    const exercicios = [_][]const u8{
        "operacoes_com_arrays",
        "resultado_operacao",
    };

    for (exercicios) |ex_name| {
        // Cria o caminho completo: "src/exercicios/nome_do_exercicio.zig"
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

        // Cria um comando de execução para este exercício específico
        const run_cmd = b.addRunArtifact(exe);

        // Registra o comando com o nome do exercício
        const run_step = b.step(ex_name, b.fmt("Roda o exercício {s}", .{ex_name}));
        run_step.dependOn(&run_cmd.step);
    }
}