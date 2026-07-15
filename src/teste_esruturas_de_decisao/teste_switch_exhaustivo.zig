const std = @import("std");

const Status = enum {
    ativo,
    inativo,
    pendente,
};

fn descricaoStatus(status: Status) []const u8 {
    return switch (status) {
        .ativo    => "Usuário ativo",
        .inativo  => "Usuário desativado",
        .pendente => "Aguardando ativação",
    };
}

pub fn main() void {
    const status = Status.ativo;
    std.debug.print("Status: {s}\n", .{descricaoStatus(status)});
}
