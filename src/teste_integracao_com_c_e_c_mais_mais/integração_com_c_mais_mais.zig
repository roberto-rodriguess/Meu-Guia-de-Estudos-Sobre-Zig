const std = @import("std");

// Declarações C das funções wrapper
extern "c" fn minha_classe_criar(valor: c_int) ?*anyopaque;
extern "c" fn minha_classe_destruir(handle: ?*anyopaque) void;
extern "c" fn minha_classe_get_valor(handle: ?*anyopaque) c_int;
extern "c" fn minha_classe_set_valor(handle: ?*anyopaque, valor: c_int) void;
extern "c" fn minha_classe_dobrar(handle: ?*anyopaque) c_int;

// Wrapper idiomático Zig
pub const MinhaClasse = struct {
    handle: ?*anyopaque,

    pub fn init(valor: i32) MinhaClasse {
        return .{
            .handle = minha_classe_criar(valor),
        };
    }

    pub fn deinit(self: *MinhaClasse) void {
        if (self.handle) |h| {
            minha_classe_destruir(h);
            self.handle = null;
        }
    }

    pub fn getValor(self: MinhaClasse) i32 {
        if (self.handle) |h| {
            return minha_classe_get_valor(h);
        }
        return 0;
    }

    pub fn setValor(self: MinhaClasse, valor: i32) void {
        if (self.handle) |h| {
            minha_classe_set_valor(h, valor);
        }
    }

    pub fn dobrar(self: MinhaClasse) i32 {
        if (self.handle) |h| {
            return minha_classe_dobrar(h);
        }
        return 0;
    }
};

pub fn main() void {
    var obj = MinhaClasse.init(21);
    defer obj.deinit();

    std.debug.print("Valor: {d}\n", .{obj.getValor()});
    std.debug.print("Dobro: {d}\n", .{obj.dobrar()});

    obj.setValor(50);
    std.debug.print("Novo valor: {d}\n", .{obj.getValor()});
}