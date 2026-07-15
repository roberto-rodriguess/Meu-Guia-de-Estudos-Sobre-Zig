const std = @import("std");

// export torna a funcao visivel para C
// callconv(.C) usa a convencao de chamada C
export fn somar(a: i32, b: i32) i32 {
    return a + b;
}

export fn fatorial(n: u32) u64 {
    if (n < 1) return 1;
    var resultado: u64 = 1;
    var i: u32 = 2;

    while (i < n) : (i += 1) {
        resultado *= @intCast(i);
    }
    return resultado;
}

// Funcoes que usam allocators podem ser exportadas
// mas precisam gerenciar memoria de forma compativel com C
export fn criar_buffer(tamanho: usize) ?[*]u8 {
    const buf = std.heap.page_allocator.alloc(u8, tamanho) catch return null;
    return buf.ptr;
}

export fn liberar_buffer(ptr: [*]u8, tamanho: usize) void {
    const slice = ptr[0..tamanho];
    std.heap.page_allocator.free(slice);
}
