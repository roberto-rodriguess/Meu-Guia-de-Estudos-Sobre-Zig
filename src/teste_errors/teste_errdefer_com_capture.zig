const std = @import("std");

fn operacaoComplexa() !void {
    const recurso = try alocar();
    errdefer |err| {
        // Acesso ao erro que causou o defer
        std.log.err("Cleanup devido a: {}", .{err});
        liberar(recurso);
    }

    try usar(recurso);
}

fn alocar() !i32 {return 42;}
fn liberar(x: i32) void {_ = x;}
fn usar(x: i32) !void {_ = x;}

pub fn main() !void {
    try operacaoComplexa();
}