const std = @import("std");

// Sistema de validação genérico
fn Validador(comptime T: type) type {
    return struct {
        const Regra = struct {
            nome: []const u8,
            validar: *const fn (T) bool,
        };

        pub fn validarTudo(valor: T, comptime regras: []const Regra) !void {
            inline for (regras) |regra| {
                if (!regra.validar(valor)) {
                    std.debug.print("❌ Falhou: {s}\n", .{regra.nome});
                    return error.ValidacaoFalhou;
                }
                std.debug.print("✅ Passou: {s}\n", .{regra.nome});
            }
        }
    };
}

fn ehPositivo(n: i32) bool {
    return n > 0;
}

fn ehPar(n: i32) bool {
    return @mod(n, 2) == 0;
}

fn menorQue100(n: i32) bool {
    return n < 100;
}

pub fn main() !void {
    const V = Validador(i32);
    const regras = [_]V.Regra {
        .{.nome = "positivo", .validar = &ehPositivo},
        .{.nome = "par", .validar = &ehPar},
        .{.nome = "menor que 100", .validar = &menorQue100},
    };

    std.debug.print("Validando 42:\n", .{});
    try V.validarTudo(41, &regras);

    std.debug.print("\nValidando -5:\n", .{});
    V.validarTudo(-5, &regras) catch {
        std.debug.print("Validação falhou (esperado)\n", .{});
    };
}
