const std = @import("std");

pub fn main() !void {
    const numeros = [_]i32{10, 20, 30, 40, 50};

    std.debug.print("Primeiro: {d}\n", .{numeros[0]});
    std.debug.print("Tamanho: {d}\n", .{numeros.len});

    const nomes = [_][]const u8{"Ana", "Bruno", "Carla"};

    for (nomes) |nome| {
        std.debug.print("Nome: {s}\n", .{nome});
    }

    const fatia: []const i32 = numeros[1..3];

    std.debug.print("Fatia: ", .{});
    for (fatia) |n| {
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});

    const matriz = [3][3]i32 {
        [_]i32{ 1, 2, 3 },
        [_]i32{ 4, 5, 6 },
        [_]i32{ 7, 8, 9 },
    };

    std.debug.print("Elementos [1][2]: {d}\n", .{matriz[1][2]});

    const mensagem = "Olá, Zig!";

    std.debug.print("Mensagem: {s}\n", .{mensagem});
    std.debug.print("Tamanho: {d} bytes\n", .{mensagem.len});

    const primeira_letra = mensagem[0];
    std.debug.print("Primeira lentra {c}\n", .{primeira_letra});

    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const part1 = "Olá";
    const part2 = "Mundo!";

    const resultado = try std.fmt.allocPrint(allocator, "{s}{s}", .{part1, part2});
    defer allocator.free(resultado);

    std.debug.print("{s}\n", .{resultado});
}
