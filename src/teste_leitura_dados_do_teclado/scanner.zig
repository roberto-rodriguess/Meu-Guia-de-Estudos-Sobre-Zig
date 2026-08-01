const std = @import("std");

extern "c" fn scanf(format: [*c]const u8, ...) c_int;

/// Lê um inteiro seguro do terminal
pub fn readInt() !i32 {
    var val: c_int = 0;
    const result = scanf("%d\x00", &val);

    // O scanf retorna o número de itens lidos com sucesso
    if (result <= 0) return error.InvalidInput;
    return @intCast(val);
}

/// Lê um número decimal de dupla precisão (f64)
pub fn readFloat() !f64 {
    var val: f64 = 0.0;
    const result = scanf("%lf\x00", &val); // %lf lê double em C

    if (result <= 0) return error.InvalidInput;
    return val;
}

/// Lê uma string com segurança, respeitando o tamanho máximo do buffer passado
pub fn readString(buf: []u8) ![]const u8 {
    if (buf.len == 0) return error.BufferTooSmall;

    // Montamos uma string de formato dinâmica, ex: se o buffer tem 20 bytes,
    // geramos o formato "%19s" para evitar estourar o buffer.
    var fmt_buf: [32]u8 = undefined;
    const fmt = try std.fmt.bufPrint(&fmt_buf, "%{d}s\x00", .{buf.len - 1});

    const result = scanf(@ptrCast(fmt.ptr), buf.ptr);
    if (result <= 0) return error.InvalidInput;

    // Calcula a fatia real da string lida até encontrar o terminador nulo '\0'
    return std.mem.sliceTo(buf, 0);
}
