const std = @import("std");

pub const BumpAllocator = struct {
    buffer: []u8,
    used: usize,

    pub fn init(buffer: []u8) BumpAllocator {
        return .{
            .buffer = buffer,
            .used = 0,
        };
    }

    pub fn allocator(self: *BumpAllocator) std.mem.Allocator {
        return .{
            .ptr = self,
            .vtable = &.{
                .alloc = alloc,
                .resize = resize,
                .free = free,
            },
        };
    }

    fn alloc(ctx: *anyopaque, len: usize, ptr_align: u8) ?[*]u8 {
        const self = @as(*BumpAllocator, @ptrCast(@alignCast(ctx)));

        // Alinha o endereço
        const addr = @intFromPtr(self.buffer.ptr) + self.used;
        const aligned_addr = std.mem.alignForward(addr, ptr_align);
        const offset = aligned_addr - @intFromPtr(self.buffer.ptr);

        // Verifica se cabe
        if (offset + len > self.buffer.len) return null;

        self.used = offset + len;
        return self.buffer.ptr + offset;
    }

    fn resize(ctx: *anyopaque, buf: []u8, buf_align: u8, new_len: usize, ret_addr: usize) bool {
        _ = ctx; _ = buf; _ = buf_align; _ = new_len; _ = ret_addr;
        // Bump allocator não suporta resize
        return false;
    }

    fn free(ctx: *anyopaque, buf: []u8, buf_align: u8, ret_addr: usize) void {
        _ = ctx; _ = buf; _ = buf_align; _ = ret_addr;
        // Bump allocator não libera individualmente
    }

    pub fn reset(self: *BumpAllocator) void {
        self.used = 0;
    }
};

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var bump = BumpAllocator.init(&buffer);

    const allocator = bump.allocator();
    const dados = try allocator.alloc(u8, 100);

    std.debug.print("Alocado: {} bytes em {:p}\n", .{dados.len, dados.ptr});
}