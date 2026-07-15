const std = @import("std");

fn descreverTipo(comptime T: type) void {
    const info = @typeInfo(T);
    switch (info) {
        .int => |i| {
            const sinal = if (i.signedness == .signed) "com sinal" else "sem sinal";
            @compileLog("Inteiro " ++ sinal, i.bits, "bits");
        },
        .float => |f| {
            @compileLog("Flaot de ", f.bits, " bits");
        },
        .@"struct" => |s| {
            @compileLog("Struct com ", s.fields.len, " campos");
            for (s.fields) |campo| {
                @compileLog("  campo: ", campo.name);
            }
        },
        .pointer => |p| {
            @compileLog("Ponteiro para ", @typeName(p.child));
        },
        else => @compileLog("Outro tipo: ", @typeName(T)),
    }
}

const Pessoa = struct {
    nome: []const u8,
    idade: u32,
    ativo: bool,
};

// Chamado em comptime — imprime informações no log de compilação
comptime {
    descreverTipo(i32);       // "Inteiro com sinal, 32 bits"
    descreverTipo(f64);       // "Float de 64 bits"
    descreverTipo(Pessoa);    // "Struct com 3 campos"
    descreverTipo(*const u8); // "Ponteiro para u8"
}
