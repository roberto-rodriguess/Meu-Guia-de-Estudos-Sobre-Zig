const std = @import("std");

/// Lê uma linha do teclado, armazenando-a no buffer fornecido e retornando a fatia de texto lida,
/// removendo os caracteres de controle de nova linha (\n e \r).
pub fn readLine(buf: []u8) ![]const u8 {
    if (buf.len == 0) return error.BufferTooSmall;

    const io = std.Io.Threaded.global_single_threaded.io();
    const stdin_file = std.Io.File.stdin();

    // Cria o reader nativo usando o buffer fornecido como área de trabalho
    var stdin_reader = stdin_file.reader(io, buf);
    const reader = &stdin_reader.interface;

    // Lê da stream até encontrar o caractere de nova linha '\n'
    const line = try reader.takeDelimiterExclusive('\n');

    // Limpa o retorno de carro '\r' no Windows
    if (line.len > 0 and line[line.len - 1] == '\r') {
        return line[0 .. line.len - 1];
    }
    return line;
}

/// Lê o teclado e converte a entrada para um tipo inteiro especificado (ex: i32, u64)
pub fn readInt(comptime T: type, buf: []u8) !T {
    const line = try readLine(buf);
    const trimmed = std.mem.trim(u8, line, " \t\r");
    return try std.fmt.parseInt(T, trimmed, 10);
}

/// Lê o teclado e converte a entrada para um tipo decimal especificado (ex: f32, f64)
pub fn readFloat(comptime T: type, buf: []u8) !T {
    const line = try readLine(buf);
    const trimmed = std.mem.trim(u8, line, " \t\r");
    return try std.fmt.parseFloat(T, trimmed);
}
