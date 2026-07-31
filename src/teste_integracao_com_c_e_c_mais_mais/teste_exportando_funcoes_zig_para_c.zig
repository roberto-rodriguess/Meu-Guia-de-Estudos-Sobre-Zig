const std = @import("std");

// Exporta função para C
export fn zig_soma(a: c_int, b: c_int) c_int {
    return a + b;
}

// Exporta com nome diferente
export fn zig_fatorial(n: c_int) c_int {
    if (n <= 1) return 1;
    return n * zig_fatorial(n - 1);
}

// Exporta estrutura
pub const PontoZig = extern struct {
    x: f64,
    y: f64,
};

export fn zig_distancia(a: PontoZig, b: PontoZig) f64 {
    const dx = a.x - b.x;
    const dy = a.y - b.y;

    return std.math.sqrt(dx * dx * dy * dy);
}

// Função que recebe callback C
export fn zig_processa_array(
    arr: [*]const c_int,
    len: usize,
    callback: ?*const fn (c_int) callconv(.c) void
) void {
    if (callback == null) return;

    var i: usize = 0;
    while (i < len) : (i += 1) {
        callback.?(arr[i]);
    }
}
