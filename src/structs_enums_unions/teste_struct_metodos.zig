const std = @import("std");

pub fn main() void {
    var c = Circulo {
        .centro = Ponto {.x = 0, .y = 0},
        .raio = 5.0
    };

    std.debug.print("Área: {d:.2}\n", .{c.area()});

    c.escalar(2.0);
    std.debug.print("Novo raio: {d}\n", .{c.raio});

    const unit = Circulo.unitario();

    std.debug.print("{}", .{unit});
}

const Ponto = struct {
    x: f64,
    y: f64,
};

const Circulo = struct {
    centro: Ponto,
    raio: f64,

    // Metodo que recebe self por valor (imutável)
    pub fn area(self: Circulo) f64 {
        return std.math.pi * self.raio * self.raio;
    }

    pub fn escalar(self: *Circulo, fator: f64) void {
        self.raio *= fator;
    }

    pub fn unitario() Circulo {
        return Circulo {
            .centro = Ponto{.x = 0, .y = 0},
            .raio = 1.0,
        };
    }
};