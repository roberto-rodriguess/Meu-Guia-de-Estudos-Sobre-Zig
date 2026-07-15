const std = @import("std");
const builtin = @import("builtin");

fn somaOtimizada(slice: []const i32) i64 {
    // Se a CPU suporta SIMD, use instruções vetoriais
    if (comptime std.Target.x86.featureSetHas(builtin.cpu.features, .avx2)) {
        return somaAVX2(slice);
    } else if (comptime std.Target.x86.featureSetHas(builtin.cpu.features, .sse2)) {
        return somaSSE2(slice);
    } else {
        return somaEscalar(slice);
    }
}

fn somaEscalar(slice: []const i32) i64 {
    var total: i64 = 0;
    for (slice) |valor| {
        total += valor;
    }
    return total;
}

fn somaSSE2(slice: []const i32) i64 {
    return somaEscalar(slice);
}

fn somaAVX2(slice: []const i32) i64 {
    return somaEscalar(slice);
}