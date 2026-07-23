const std = @import("std");

const c = @cImport({
    @cInclude("worker.h");
});

const Context = struct {
    total_itens: usize,
    processed: usize,
};

fn onProcess(percent: c_int, user_data: ?*anyopaque) callconv(.c) void {
    // Unwrapping do optional com .? e alinhamento do ponteiro
    const ctx: *Context = @ptrCast(@alignCast(user_data.?));
    
    // Atualiza a contagem baseado na percentagem
    ctx.processed = (ctx.total_itens * @as(usize, @intCast(percent))) / 100;
    
    std.debug.print("Progresso: {d}% ({d}/{d} itens)\n", .{
        percent,
        ctx.processed,
        ctx.total_itens,
    });
}

pub fn main() void {
    var ctx = Context{
        .total_itens = 80,
        .processed = 0,
    };

    c.do_work(onProcess, &ctx);
}