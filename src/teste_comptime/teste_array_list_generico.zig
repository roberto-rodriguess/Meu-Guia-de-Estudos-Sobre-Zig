const std = @import("std");
const Allocator = std.mem.Allocator;

fn ArrayList(comptime T: type) type {
    return struct {
        itens: []T,
        capacidade: usize,
        tamanho: usize,
        allocator: Allocator,

        const Self = @This();

        pub fn init(allocator: Allocator) Self {
            return .{
                .itens = &[_]T{},
                .capacidade = 0,
                .tamanho = 0,
                .allocator = allocator,
            };
        }

        pub fn deinit(self: *Self) void {
            if (self.capacidade > 0) {
                self.allocator.free(self.itens.ptr[0..self.capacidade]);
            }
        }

        pub fn apped(self: *Self, item: T) !void {
            if (self.tamanho >= self.capacidade) {
                try self.crescer();
            }
            self.itens.ptr[self.tamanho] = item;
            self.tamanho += 1;
            self.itens.len = self.tamanho;
        }

        pub fn get(self: Self, indice: usize) T {
            if (indice >= self.tamanho) {
                @panic("índice fora dos limites");
            }
            return self.itens[indice];
        }

        pub fn slice(self: Self) []const T {
            return self.itens.ptr[0..self.tamanho];
        }

        fn crescer(self: *Self) !void {
            const nova_capacidade = if (self.capacidade == 0) 8 else self.capacidade * 2;

            const novo_buf = try self.allocator.alloc(T, nova_capacidade);

            if (self.tamanho > 0) {
                @memcpy(novo_buf[0..self.tamanho], self.itens.ptr[0..self.tamanho]);
            }

            self.itens.ptr = novo_buf.ptr;
            self.itens.len = self.tamanho;
            self.capacidade = nova_capacidade;
        }

        // Informações de tipo disponíveis em comptime
        pub const Item = T;
        pub const tamanho_item = @sizeOf(T);
    };
}

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    // ArrayList de inteiros
    var numeros = ArrayList(i32).init(allocator);
    defer numeros.deinit();

    try numeros.apped(10);
    try numeros.apped(20);
    try numeros.apped(30);

    for (numeros.slice()) |n| {
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});

    // ArrayList de strings
    var nomes = ArrayList([]const u8).init(allocator);
    defer nomes.deinit();

    try nomes.apped("Ana");
    try nomes.apped("Bruno");
    try nomes.apped("Carlos");

    for (nomes.slice()) |nome| {
        std.debug.print("{s} ", .{nome});
    }
    std.debug.print("\n", .{});

    // Meta-informação disponível em comptime
    std.debug.print("Tamanho de cada item (i32): {} bytes\n", .{ArrayList(i32).tamanho_item});
    std.debug.print("Tamanho de cada item (f64): {} bytes\n", .{ArrayList(f64).tamanho_item});
}
