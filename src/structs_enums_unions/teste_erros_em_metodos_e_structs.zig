const std = @import("std");

const Contador = struct {
    valor: i32,
    maximo: i32,

    const Erro = error {LimiteExedido};

    pub fn incrementar(self: *Contador) Erro!void {
        if (self.valor >= self.maximo) {
            return Erro.LimiteExedido;
        }
        self.valor += 1;
    }

    pub fn novo(maximo: i32) Contador {
        return .{
            .valor = 0,
            .maximo = maximo,
        };
    }
};

pub fn main() !void {
    var contador = Contador.novo(5);
    const p = &contador;
    p.valor = 10;

    var i: i32 = 0;
    while (i < 10) : (i += 1) {
        contador.incrementar() catch |err| {
            std.debug.print("Erro na iteração {d}: {}\n", .{i, err});
            break;
        };
    }

    std.debug.print("Valor final: {d}\n", .{contador.valor});
}
