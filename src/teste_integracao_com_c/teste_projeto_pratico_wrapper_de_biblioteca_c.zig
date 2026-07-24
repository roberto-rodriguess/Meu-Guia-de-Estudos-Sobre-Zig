// Wrapper Zig Idiomático
const std = @import("std");
const clog = @import("clog.zig");

pub fn main() !void {
    // Criar logger (wrapper idiomático)
    const logger = try clog.Logger.new("MyApp", .info);
    defer logger.deinit();

    // Usar com API Zig amigável
    logger.info("Aplicação iniciada", .{});
    logger.debug("Isso não vai aparecer (nível mínimo é info", .{});

    const user_count = 42;
    logger.info("Usuário conectados: {}", .{user_count});

    // Mudar nível dinamicamente
    logger.setLevel(.debug);
    logger.debug("Agora debug aparece!", .{});

    // Error com formatação
    const filename = "dados.txt";
    logger.err("falha ao abrir arquivo: {s}", .{filename});
}