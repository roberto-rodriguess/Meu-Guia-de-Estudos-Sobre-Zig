
const ResultadoOperacao = struct {
    sucesso: bool,
    erro: ?ErroDetalhado,
    dados: ?[]const u8,
};

const ErroDetalhado = struct {
    codigo: u32,
    mensagem: []const u8,
    timestamp: i64,
};

pub fn main() void {

}