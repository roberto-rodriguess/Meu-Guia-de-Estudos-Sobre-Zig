const std = @import("std");

pub fn main() !void {
    const Operacao = struct {
        fn executar(a: i32, b: i32, operacao: fn (i32, i32) i32) i32 {
            return operacao(a, b);
        }
    };

    const soma = struct {
        fn call(x: i32, y: i32) i32 {
            return x + y;
        }
    }.call;

    const resultado = Operacao.executar(5, 3, soma);
    std.debug.print("5 + 3 = {d}\n", .{resultado});
}
