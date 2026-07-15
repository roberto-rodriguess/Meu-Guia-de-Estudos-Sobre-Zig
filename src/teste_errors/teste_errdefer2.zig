    const std = @import("std");

const Erro = error {ErroAoAbrirArquivo};

const Arquivo = struct {
    nome: []const u8,
    //aberto: bool,

    fn abrir(nome: []const u8) Erro!Arquivo {
        const falhou = false;

        if (!falhou) return Erro.ErroAoAbrirArquivo;

        return Arquivo {.nome = nome};
    }

    fn fechar(self: Arquivo) void {
        std.debug.print("Fechando: {s}...\n", .{self.nome});
    }
};

fn processarArquivos() !void {
    const arquivo1 = try Arquivo.abrir("arquivo1.txt");
    errdefer arquivo1.fechar();

    const arquivo2 = try Arquivo.abrir("arquivo2.txt");
    errdefer arquivo2.fechar();

    try processar(arquivo1, arquivo2);

    arquivo1.fechar();
    arquivo2.fechar();
}

fn processar(a: Arquivo, b: Arquivo) !void {
    _ = a; _ = b;
}

pub fn main() !void {
    try processarArquivos();
}
