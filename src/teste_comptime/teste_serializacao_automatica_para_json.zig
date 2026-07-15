const std = @import("std");

fn paraJSON(comptime T: type, valor: T, writer: anytype) !void {
    const info = @typeInfo(T);
    switch (info) {
        .@"struct" => |s| {
            try writer.writeAll("{");
            var primeiro = true;
            inline for (s.fields) |campo| {
                if (!primeiro) try writer.writeAll(",");
                primeiro = false;
                try writer.print("\"{s}\":", .{campo.name});
                try paraJSON(campo.type, @field(valor, campo.name), writer);
            }
            try writer.writeAll("}");
        },
        .int, .comptime_int => writer.print("{}", .{valor}),
        .float, .comptime_float => try writer.print("{d}", .{valor}),
        .bool => try writer.print("{}", .{valor}),
        .pointer => |ptr| {
            if (ptr.size == .slice and ptr.child == u8) {
                try writer.print("\"{s}\"", .{valor});
            }
        },
        .optional => {
            if (valor) |v| {
                try paraJSON(@typeInfo(T).optional.child, v, writer);
            } else {
                try writer.writeAll("null");
            }
        },
        else => try writer.writeAll("null"),
    }
}

const Produto = struct {
    nome: []const u8,
    preco: f64,
    estoque: u32,
    disponivel: bool,
};

pub fn main(init: std.process.Init) !void {
    const produto = Produto {
        .nome = "Teclado Mecânico",
        .preco = 299.90,
        .estoque = 42,
        .disponivel = true,
    };

    //const stdout = std.io.getStdOut().writer();
    //try paraJSON(Produto, produto, stdout);

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    try paraJSON(Produto, produto, stdout);
    try stdout.flush();
}
