const std = @import("std");

const Resultado = union(enum) {
    sucesso: []const u8,
    erro: Erro,

    const Erro = struct {
        codigo: u32,
        mensagem: []const u8,
    };

    pub fn estaOk(self: Resultado) bool {
        return self == .sucesso;
    }

    pub fn getMensagem(self: Resultado) []const u8 {
        return switch (self) {
            .sucesso => |s| s,
            .erro => |e| e.mensagem,
        };
    }
};

fn operacaoArquivos() Resultado {
    const sucesso = false;

    if (sucesso) {
        return .{.sucesso = "Arquivo processado com sucesso!"};
    } else {
        return .{.erro = .{
            .codigo = 404,
            .mensagem = "Arquivo não encontrado!",
        }};
    }
}

pub fn main() void {
    const resultado = operacaoArquivos();

    if (resultado.estaOk()) {
        std.debug.print("{s}\n", .{resultado.getMensagem()});
    } else {
        std.debug.print("Erro: {s}\n", .{resultado.getMensagem()});
    }
}
