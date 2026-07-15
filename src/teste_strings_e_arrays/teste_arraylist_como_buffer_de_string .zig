const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    // usar ArrayList(u8) como StringBuilder
    // var builder = std.ArrayList(u8).empty;
    var builder = std.array_list.Managed([]const u8).init(allocator);
    defer builder.deinit();

    // construir string gradualmente
    try builder.append("Olá");
    try builder.append(",");
    try builder.append(" ");
    try builder.appendSlice("mundo");
    try builder.append("!");

    // converter pra slice
    const mensagem = builder.items;
    std.debug.print("{s}\n", .{mensagem});

    // ou converter pra string alocada
    const mensagem_owned = try allocator.dupe(u8, builder.items);
    defer allocator.free(mensagem_owned);

    std.debug.print("{s}\n", .{mensagem_owned});
}
