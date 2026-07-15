const std = @import("std");

const Erro = error {ErroAoAbrirArquivo};

const Arquivo = struct {
    nome: []const u8,
    aberto: bool,

    fn fechar(self: Arquivo) void {
        std.debug.print("Fechando {s}...\n", .{self.nome});
    }
};

fn processarArquivos() !void {
    const arquivo1 = try abrir("arquivo1.txt");

    const arquivo2 = try abrir("arquivo2.txt");

    arquivo1.fechar();
    arquivo2.fechar();
}

fn abrir(nome: []const u8) Erro!Arquivo {
    const falhou = false;

    if (!falhou) return Erro.ErroAoAbrirArquivo;

    const arquivo = Arquivo {
        .nome = nome,
        .aberto = true,
    };

    std.debug.print("{s} aberto\n", .{nome});

    return arquivo;
}

pub fn main() !void {
    try processarArquivos();
}