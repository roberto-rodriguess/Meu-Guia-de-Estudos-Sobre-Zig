const std = @import("std");

const math = struct {
    // Público: acessível de fora
    pub fn soma(a: i32, b: i32) i32 {
        return a + b;
    }

    // Privado: só acessível dentro deste struct
    fn subtracao(a: i32, b: i32) i32 {
        return a - b;
    }

    // Pode chamar função privada de pública
    pub fn operacaoSecreta(a: i32, b: i32) i32 {
        return subtracao(a, b);
    }
};

pub fn main() void {
    const resultado1 = math.soma(5, 3);
    const resultado2 = math.subtracao(5, 3);
    const resultado3 = math.operacaoSecreta(5, 3);

    std.debug.print("Soma: {d}\n", .{resultado1});
    std.debug.print("Subtração: {d}\n", .{resultado2});
    std.debug.print("Operação secreta: {d}\n", .{resultado3});
}
