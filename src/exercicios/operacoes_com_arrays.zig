const std = @import("std");

pub fn main() void {
    const notas = [_]f64 {8.5, 9.0, 7.5, 10.0, 6.5};

    std.debug.print("Estatísticas das Notas:\n", .{});
    std.debug.print("  Média: {d:.2}\n", .{media(&notas)});
    std.debug.print("  Máximo: {d:.1}\n", .{maximo(&notas)});
    std.debug.print("  Mínimo: {d:.1}\n", .{minimo(&notas)});
}

fn media(numeros: []const f64) f64 {
    var soma: f64 = 0;
    for (numeros) |n| {
        soma += n;
    }
    return soma / @as(f64, @floatFromInt(numeros.len));
}

fn maximo(numeros: []const f64) f64 {
    var max = numeros[0];
    for (numeros[1..]) |n| {
        if (n > max) max = n;
    }
    return max;
}

fn minimo(numeros: []const f64) f64 {
    var min = numeros[0];
    for (numeros[1..]) |n| {
        if (n < min) min = n;
    }
    return min;
}
