// Regras de Ouro
// Quem aloca, libera: Se C alocou memória, C deve liberar
// Não misture allocators: Use std.heap.c_allocator para memória que será liberada por C
// Cuidado com lifetimes: Ponteiros C não têm lifetime tracking

const std = @import("std");

// Exemplo Seguro: Passando Strings
extern "c" fn processa_string(s: [*c]const u8) void;

// ❌ ERRADO: ponteiro pode ficar inválido
pub fn enviarMensagemErrada(msg: []const u8) void {
    processa_string(msg.ptr); // msg pode não ser null-terminated!
}

pub fn enviarMensagemSegura(msg: []const u8) !void {
    // dupeZ aloca e adiciona null terminator
    const c_msg = try std.heap.c_allocator.dupeZ(u8, msg);
    defer std.heap.c_allocator.free(c_msg); // Zig libera

    processa_string(c_msg.ptr);
}

// ✅ CORRETO: C libera memória que C alocou
extern "c" fn cria_string() ?[*:0]u8;
extern "c" fn libera_string(s: ?[*:0]u8) void;

pub fn usarStringC() !void {
    const c_str = cria_string() orelse return error.OutOfMemory;
    defer libera_string(c_str); // C libera

    // Converte para slice Zig
    const len = std.mem.len(c_str);
    const slice = c_str[0..len];

    std.debug.print("String de C: {s}\n", .{slice});
}

// Usando std.heap.c_allocator
// Este allocator usa malloc/free da libc, garantindo compatibilidade:

extern "c" fn recebe_buffer(buf: [*c]u8, len: usize) void;

pub fn exemploAlocacao() !void {
    // Usa o allocator compatível com C
    const allocator = std.heap.c_allocator;

    const buffer = try allocator.alloc(u8, 1024);
    defer allocator.free(buffer);

    // Passa para C
    recebe_buffer(buffer.ptr, buffer.len);

    // C pode manter referência temporária, mas não deve guardar
    // o ponteiro após a função retornar
}

// extern "c" fn system(command: [*c]const u8) c_int;
const system = @import("util");

pub fn main() !void {
    const msg = "Olá, C!";
    enviarMensagemErrada(msg);
    try enviarMensagemSegura(msg);

    try usarStringC();

    try exemploAlocacao();

    //_ = system("pause\x00");
    try system.pause();
}
