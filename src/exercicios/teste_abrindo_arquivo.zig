const std = @import("std");

const Contagem = struct {
    linhas: u32 = 0,
    palavras: u32 = 0,
    caracteres: u32 = 0,
};

const ContagemErro = error {
    ArquivoNaoEncontrado,
    SemPermissao,
    ErroLeitura,
};

fn contar(io: std.Io, caminho: []const u8) !Contagem {
    // Abrir arquivo — erros são tratados automaticamente com 'try'
    const arquivo = std.Io.Dir.cwd().openFile(io, caminho, .{}) catch |err| {
        std.debug.print("Erro ao abrir '{s}': {}\n", .{ caminho, err });
        return err;
    };
    defer arquivo.close(io); // Fecha automaticamente ao sair do escopo

    var resultado = Contagem {};
    var em_palavras = false;

    // Novo (Padrão Zig 0.16.0)
    // No Zig 0.16.0, usamos std.Io.Reader.buffered() passando a referência do reader
    //var buf_reader = std.Io.Reader.buffered(arquivo.reader());
    //const reader = buf_reader.reader();

    // 1. Defina um buffer diretamente (ex: 4KB é um tamanho padrão muito eficiente)
    var buffer_leitura: [4096]u8 = undefined;

    // 2. Chame o reader passando a instância 'io' e o buffer
    var file_reader = arquivo.reader(io, &buffer_leitura);

    // 3. Pegue a interface real de leitura para usar no loop
    const reader = &file_reader.interface;

    while (true) {
        // No Zig 0.16.0, usamos .take(1) para pegar 1 byte de forma eficiente.
        // Ele retorna um slice ([]const u8).
        const byte_slice = reader.take(1) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        const byte = byte_slice[0];

        resultado.caracteres += 1;

        if (byte == '\n') resultado.linhas += 1;

        if (std.ascii.isWhitespace(byte)) {
            em_palavras = false;
        } else if (!em_palavras) {
            em_palavras = true;
            resultado.palavras += 1;
        }
    }
    return resultado;
}

pub fn main(init: std.process.Init) !void {
    // No Zig 0.16.0, o 'init' já traz uma arena pronta.
    // Não precisa inicializar nem dar 'defer deinit()' nela manualmente!
    const arena = init.arena.allocator();

    // CORREÇÃO AQUI: adicionado o '.minimal.' antes do 'args'
    const args = try init.minimal.args.toSlice(arena);

    if (args.len != 2) {
        std.debug.print("Uso: {s} <arquivo>\n", .{args[0]});
        std.process.exit(1);
    }

    const io = init.io;
    const resultado = try contar(io, args[1]);

    // Setup do stdout formatado conforme padrões do Zig 0.16.0
    const stdout_file = std.Io.File.stdout();
    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer = stdout_file.writer(io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("Linhas:     {}\n", .{resultado.linhas});
    try stdout.print("Palavras:   {}\n", .{resultado.palavras});
    try stdout.print("Caracteres: {}\n", .{resultado.caracteres});

    try stdout.flush();
}