const std = @import("std");

fn MapaEstatico(comptime chaves: []const []const u8, comptime V: type,) type {
    return struct {
        valores: [chaves.len]V,

        const Self = @This();

        // Busca O(n) mas com N pequeno e inline, é mais rápido
        // que hash map para poucos elementos
        pub fn get(self: Self, chave: []const u8) ?V {
            inline for (chaves, 0..) |k, i| {
                if (std.mem.eql(u8, k, chave)) {
                    return self.valores[i];
                }
            }
            return null;
        }

        pub fn init(valores: [chaves.len]V) Self {
            return .{.valores = valores};
        }

        // Validação em comptime: chaves duplicadas
        comptime {
            for (chaves, 0..) |a, i| {
                for (chaves[i + 1 ..]) |b| {
                    if (std.mem.eql(u8, a, b)) {
                        @compileError("Chaves duplicadas no mapa: " ++ a);
                    }
                }
            }
        }
    };
}

pub fn main() void {
    // Mapa de HTTP status codes
    const StatusMap = MapaEstatico(
        &.{ "200", "201", "301", "400", "404", "500" },
        []const u8
    );

    const status = StatusMap.init(.{
        "OK",
        "Created",
        "Moved Permanently",
        "Bad Request",
        "Not Found",
        "Internal Server Error",
    });

    // Busca é otimizada pelo compilador
    if (status.get("404")) |desc| {
        std.debug.print("404 = {s}\n", .{desc});
    }
    if (status.get("200")) |desc| {
        std.debug.print("200 = {s}\n", .{desc});
    }
    if (status.get("999")) |desc| {
        std.debug.print("999 = {s}\n", .{desc});
    } else {
        std.debug.print("999 = não encontrado\n", .{});
    }
}