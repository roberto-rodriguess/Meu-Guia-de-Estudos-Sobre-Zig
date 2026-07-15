const std = @import("std");

const Configuracao = struct {
    host: []const u8 = "localhost",
    porta: u16 = 8000,
    max_conexoes: u32 = 100,
    debug: bool = false,
    timeout_ms: u64 = 5000,
};

fn imprimirCampos(comptime T: type, valor: T) void {
    const info = @typeInfo(T).@"struct";
    std.debug.print("=== {s} ===\n", .{@typeName(T)});
    inline for (info.fields) |campo| {
        const v = @field(valor, campo.name);
        std.debug.print("  {s}: {any}\n", .{ campo.name, v });
    }
}

pub fn main() void {
    const config = Configuracao {
        .host = "meuservidor.com",
        .porta = 3000,
    };
    
    imprimirCampos(Configuracao, config);
}
