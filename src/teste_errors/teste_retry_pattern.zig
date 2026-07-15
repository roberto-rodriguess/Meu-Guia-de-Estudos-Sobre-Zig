const std = @import("std");

const ErroRede = error {Timeout, ConexaoRecusada};

fn enviarComRetry(io: std.Io, dados: []const u8, maxTentativas: u32,) !void {
    var tentativa: u32 = 0;

    retry: while (tentativa < maxTentativas) : (tentativa += 1) {
        enviar(dados) catch |err| {
            if (tentativa == maxTentativas - 1) return err;

            std.log.warn("Tentativa {d} falhou: {}. Retentando...", .{
                tentativa + 1, err,
            });

            try io.sleep(.fromSeconds(1), .awake);
            continue :retry;
        };

        return;
    }
}

fn enviar(dados: []const u8) ErroRede!void {
    _ = dados;
}

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    var threaded_io: std.Io.Threaded = .init(allocator, .{});
    defer threaded_io.deinit();

    const io = threaded_io.io();

    const dados: []const u8 = "dados";

    try enviarComRetry(io, dados, 40);
}