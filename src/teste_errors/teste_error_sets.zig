const std = @import("std");

const ErroIO = error {ArquivoNaoEncontrado, PermissaoNegada};
const ErroRede = error {Timeout, ConexaoRecusada};

const ErroApp = ErroIO || ErroRede;

fn operacaoComplexa() ErroApp!void {
    // Pode retornar qualquer erro de ErroIO ou ErroRede
}

pub fn main() !void {

}
