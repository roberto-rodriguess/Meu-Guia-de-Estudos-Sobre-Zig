const std = @import("std");
const c = @cImport({
    @cInclude("mylib.h");
});

pub fn main() void {
    // Criar instância na heap C
    const p = c.point_create(10, 20);
    if (p == null) {
        std.debug.print("Falha ao criar ponto\n", .{});
        return;
    }
    defer c.point_destroy(p);

    // Acessar campos
    std.debug.print("Ponto: x = {}, y = {}\n", .{p.*.x, p.*.y});

    // Modificar
    c.point_move(p, 5, -3);
    std.debug.print("Após mover: x = {}, y = {}\n", .{p.*.x, p.*.y});

    // Definir um nome para o ponto usando @memcpy (castando o array de i8/u8 do C)
    const name_dest: []u8 = @ptrCast(p.*.name[0..9]);
    @memcpy(name_dest, "Meu Ponto");

    // Acessar array (convertendo o array de C char para slice do Zig)
    const name_slice: []const u8 = @ptrCast(p.*.name[0..]);
    std.debug.print("Nome: {s}\n", .{std.mem.sliceTo(name_slice, 0)});

    if (p) |point| {
        // No Zig, para acessar campos de um ponteiro C ([*c]), precisamos desreferenciá-lo primeiro com `.*`
        std.debug.print("Ponto criado via C API: X = {d}, Y = {d}\n", .{point.*.x, point.*.y});
    } else {
        std.debug.print("Falha ao criar o Ponto.\n", .{});
    }
}
