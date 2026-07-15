const std = @import("std");

// Função que cria um tipo de array com tamanho customizado
fn Array(comptime T: type, comptime tamanho: comptime_int) type {
    return [tamanho]T;
}

// Função que cria um tipo de par (tupla tipada)
fn Par(comptime A: type, comptime B: type) type {
    return struct {
        primeiro: A,
        segundo: B,

        const Self = @This();

        pub fn criar(a: A, b: B) Self {
            return .{ .primeiro = a, .segundo = b };
        }

        pub fn trocar(self: Self) Par(B, A) {
            return Par(B, A).criar(self.segundo, self.primeiro);
        }
    };
}

pub fn main() void {
    // Tipo Array de 5 inteiros
    const MeuArray = Array(i32, 5);
    var arr: MeuArray = .{1, 2, 3, 4, 5};
    arr[0] = 10;

    // Tipo Par de string e inteiro
    const par = Par([]const u8, i32).criar("idade", 30);
    std.debug.print("{s} = {}\n", .{ par.primeiro, par.segundo });

    // Trocar os elementos do par
    const invertido = par.trocar();
    std.debug.print("{} = {}\n", .{ invertido.primeiro, invertido.segundo });
}