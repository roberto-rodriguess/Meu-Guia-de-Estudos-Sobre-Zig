const std = @import("std");

const Ponto = struct {
    x: f64,
    y: f64,

    pub fn distancia(self: Ponto, outro: Ponto) f64 {
        const dx = self.x - outro.x;
        const dy = self.y - outro.y;

        return std.math.sqrt(dx * dx * dy * dy);
    }
};

pub fn main() void {
    const p1 = Ponto {
        .x = 10.00,
        .y = 20.00,
    };

    const p2 = Ponto {
        .x = 30.00,
        .y = 40.00,
    };
    
    const d = p1.distancia(p2);

    std.debug.print("Distância de p1 a p2 = {d}", .{d});
}
