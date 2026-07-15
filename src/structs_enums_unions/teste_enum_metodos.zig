const std = @import("std");

const Status = enum {
    ativo,
    inativo,
    suspenso,

    pub fn podeAcessar(self: Status) bool {
        return self == .ativo;
    }

    pub fn descrissao(self: Status) []const u8 {
        return switch (self) {
            .ativo => "Usuário ativo",
            .inativo => "Usuário inativo",
            .suspenso => "Usuário suspenso",
        };
    }
};

pub fn main() !void {
    const status = Status.ativo;

    std.debug.print("Pode passar? {s}\n", .{if (status.podeAcessar()) "sim" else "não"});
    std.debug.print("Descrição: {s}\n", .{status.descrissao()});
}
