const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Criar ArrayList de inteiros
    var lista = std.ArrayList(i32).empty;
    defer lista.deinit(allocator);

    // Adicionar elementos
    try lista.append(allocator, 10);
    try lista.append(allocator, 20);
    try lista.append(allocator,30);

    // Adicionar múltiplos elementos
    try lista.appendSlice(allocator, &.{ 40, 50, 60 });

    // Inserir em posição específica
    try lista.insert(allocator,1, 15);

    // Acessar elementos
    std.debug.print("Primeiro: {d}\n", .{lista.items[0]});
    std.debug.print("Tamanho: {d}\n", .{lista.items.len});

    // Iterar
    std.debug.print("Elementos:\n", .{});
    for (lista.items) |item| {
        std.debug.print("  {d}\n", .{item});
    }

    // Remover elemento
    _ = lista.orderedRemove(2);

    // Limpar tudo
    lista.clearRetainingCapacity();

    // 2. Inicialize passando o alocador direto
    var lista2 = std.array_list.Managed(i32).init(allocator);

    // Libera a memória sem precisar passar o alocador como argumento!
    defer lista2.deinit();

    // Métodos também não precisam do alocador
    try lista2.append(10);
    try lista2.append(20);
}
