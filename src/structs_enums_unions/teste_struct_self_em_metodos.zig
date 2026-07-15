const std = @import("std");


pub fn main() void {
    var meuStruct = MeuStruct {.valor = 8};

    meuStruct.valor = 9;

    std.debug.print("Acesso direto: {d}\n", .{meuStruct.valor});
    std.debug.print("Acesso via método getValorCopia: {d}\n", .{meuStruct.getValorCopia()});
    std.debug.print("Acesso via método getValorReferencia: {d}\n", .{meuStruct.getValorReferencia()});

    meuStruct.setValor(10);
}

const MeuStruct = struct {
    valor: i32,

    // self por valor (cópia)
    pub fn getValorCopia(self: MeuStruct) i32 {
        return self.valor;
    }

    // self por referência constante
    pub fn getValorReferencia(self: *const MeuStruct) i32 {
        return self.valor;
    }

    // self por referência mutável
    pub fn setValor(self: *MeuStruct, novo: i32) void {
        self.valor = novo;
    }
};
