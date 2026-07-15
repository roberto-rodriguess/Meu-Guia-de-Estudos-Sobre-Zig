const std = @import("std");

const ErroConfig = error {ConfigNaoEncontrada, ConfigInvalida};

fn carregarConfig(caminho: []const u8) ErroConfig!Config {
    std.debug.print("caminho: {s}\n", .{caminho});
    const config = Config {
        .porta = 8888,
        .host = "1.1.1.1",
    };

    return config;
}

const Config = struct {
    porta: u16 = 8080,
    host: []const u8 = "localhost",
};

pub fn main() void {
    // Valor padrão simples
    const config = carregarConfig("app.conf") catch Config {
        .porta = 3000,
        .host = "0.0.0.0",
    };

    std.debug.print("config: {any}\n", .{config});

    // Tratamento específico
    const ponta = parsePorta("8080") catch |err| blk: {
        std.debug.print("Porta inválida: {}\n", .{err});
        break :blk 8080; // fallback
    };

    std.debug.print("porta: {d}\n", .{ponta});

    // Log e re-trow
    const dados = buscarDados() catch |err| {
        std.log.err("Falha ao buscar dados: {s}\n", .{err});
        return;
    };

    std.debug.print("dados: {s}\n", .{dados});
}

fn parsePorta(texto: []const u8) !u16 {
    return std.fmt.parseInt(u16, texto, 10);
}

fn buscarDados() ![]const u8 {
    return "dados";
}
