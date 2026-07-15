const std = @import("std");

const StatusPedido = enum {
    pendente,
    processando,
    enviando,
    entregue,
    cancelado,
};

const Cor = enum {
    vermelho,
    verde,
    azul,
};

// Enum com tipo subjacente específico
const CodigoErro = enum(u8) {
    sucesso = 0,
    arquivo_nao_encontrado = 1,
    permissao_negada = 2,
    memoria_insuficiente = 3,
    timeout = 4,
};

// Tamanho explícito
comptime {
    std.debug.assert(@sizeOf(CodigoErro) == 1);
}

const FlagsPermissao = enum(u8) {
    nenhuma = 0,
    leitura = 1 << 0,
    escrita = 1 << 1,
    execussao = 1 << 2,
    todas = 0b111,
};

pub fn main() !void {
    const codigo = @intFromEnum(CodigoErro.arquivo_nao_encontrado);
    std.debug.print("{d}", .{codigo});

    // const erro = @enumFromInt(CodigoErro, 2);

    const tipoSubjacente = @typeInfo(FlagsPermissao).Enum.tag_type;
    std.debug.print("{}", .{tipoSubjacente});
}
