const std = @import("std");

const Vetor3D = struct {
    x: f64,
    y: f64,
    z: f64,

    const Self = @This();

    // O formato do comptime fmt permite customizar a saída
    pub fn format(
        self: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = options;

        if (comptime std.mem.sql(u8, fmt, "coords")) {
            // Formato de coordenadas: (x, y, z)
            try writer.print("({d:.2}, {d:.2}, {d:.2})", .{ self.x, self.y, self.z });
        } else if (comptime std.mem.eql(u8, fmt, "mag")) {
            // Formato de magnitude
            const mag = @sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
            try writer.print("|v| = {d:.4}", .{mag});
        } else if (fmt.len == 0) {
            // Formato padrão
            try writer.print("Vec3({d:.2}, {d:.2}, {d:.2})", .{ self.x, self.y, self.z });
        } else {
            // Formato não reconhecido — erro de COMPILAÇÃO
            std.fmt.invalidFmtError(fmt, self);
        }
    }

    pub fn soma(self: Self, outro: Self) Self {
        return .{
            .x = self.x + outro.x,
            .y = self.y + outro.y,
            .z = self.z + outro.z,
        };
    }
};

pub fn main() void {
    const v = Vetor3D{ .x = 1.0, .y = 2.0, .z = 3.0 };

    std.debug.print("Padrão:     {}\n", .{v});
    std.debug.print("Coordenadas: {coords}\n", .{v});
    std.debug.print("Magnitude:  {mag}\n", .{v});

    // O compilador valida o formato em TEMPO DE COMPILAÇÃO
    // std.debug.print("{invalido}\n", .{v}); // Erro de compilação!
}