const std = @import("std");

const MeuErro = error {NaoEncontrado, Timeout};
const OutroErro = error {PermissaoNegada};

fn podeFalhar() anyerror!void {
    return error.NaoEncontrado;
}

pub fn main() !void {
    const e = podeFalhar();

    std.debug.print("{any}", .{e});
}
