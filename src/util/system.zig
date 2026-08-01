const std = @import("std");

/// Pausa a execução do programa e aguarda o usuário pressionar Enter
pub fn pause() !void {
    const io = std.Io.Threaded.global_single_threaded.io();
    
    const stdout_file = std.Io.File.stdout();
    const stdin_file = std.Io.File.stdin();

    var buf_out: [64]u8 = undefined;
    var stdout_writer = stdout_file.writer(io, &buf_out);
    const writer = &stdout_writer.interface;

    try writer.writeAll("Pressione Enter para continuar . . . ");
    try writer.flush();

    var buf_in: [1]u8 = undefined;
    var stdin_reader = stdin_file.reader(io, &buf_in);
    const reader = &stdin_reader.interface;

    _ = try reader.takeByte();
}
