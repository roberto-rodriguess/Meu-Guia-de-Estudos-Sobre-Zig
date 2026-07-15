const std = @import("std");

// Buffer global (útil para singletons)
var buffer_global: [1024 * 1024]u8 = undefined;
var fba = std.heap.FixedBufferAllocator.init(&buffer_global);

pub fn alocacaoEstatica() !void {
    const allocator = fba.allocator();

    const dados = try allocator.alloc(u8, 1000);

    const checkpoint = fba.end_index;
    // ... faz alocações ...
    
    fba.end_index = checkpoint; // "Desfaz" alocações desde checkpoint

    // Para reutilizar o buffer, reset:
    fba.reset();
}
