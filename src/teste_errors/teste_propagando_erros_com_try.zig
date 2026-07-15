const std = @import("std");

const ErroOperacao = error {DivisaoPorZero, OverFlow};

fn divisaoSegura(a: i32, b:i32) ErroOperacao!i32 {
    if (b == 0) return ErroOperacao.DivisaoPorZero;

    return @divTrunc(a, b);
}

// Usando try
fn calcularMedia(a: i32, b: i32) ErroOperacao!i32 {
    const soma = try adicionar(a, b); // Propaga erro se falhar
    return try divisaoSegura(soma, 2);     // Propaga erro se falhar
}

fn adicionar(a: i32, b: i32) ErroOperacao!i32 {
    const resutado = @addWithOverflow(a, b);
    if (resutado != 0) return error.OverFlow;

    return resutado[0];
}

pub fn main() !void {
    const r1 = try divisaoSegura(10, 8);

    std.debug.print("r1 = {d}\n", .{r1});

    const r2 = divisaoSegura(10, 8);

    if (r2) |s| {
        std.debug.print("r2 = {d}\n", .{s});
    } else |err| {
        std.debug.print("r2 = {any}\n", .{err});
    }

    const r3 = divisaoSegura(20, 1) catch |err| return err;
    std.debug.print("r3 = {d}\n", .{r3});

    const r4 = divisaoSegura(20, 0) catch -1;
    std.debug.print("r4 = {d}\n", .{r4});
}
