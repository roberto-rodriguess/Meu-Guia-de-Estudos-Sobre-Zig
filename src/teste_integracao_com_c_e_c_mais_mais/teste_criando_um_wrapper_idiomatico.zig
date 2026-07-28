const std = @import("std");
// Declarações externas (low-level)
extern "c" fn fopen(filename: [*c]const u8, mode: [*c]const u8) ?*FILE;
extern "c" fn fclose(file: ?*FILE) c_int;
extern "c" fn fprintf(file: ?*FILE, format: [*c]const u8, ...) c_int;

const FILE = opaque {};

// Wrapper idiomático em Zig
pub const FileMode = enum {
    read,
    write,
    append,
};

pub const CFile = struct {
    handle: ?*FILE,

    pub fn open(path: []const u8, mode: FileMode) !CFile {
        const mode_str = switch (mode) {
            .read => "r",
            .write => "w",
            .append => "a",
        };

        // Converte []const u8 para [*c]const u8 (null-terminated)
        const c_path = try std.heap.c_allocator.dupeZ(u8, path);
        defer std.heap.c_allocator.free(c_path);

        const handle = fopen(c_path.ptr, mode_str);
        if (handle == null) return error.FileNotFound;

        return CFile{.handle = handle};
    }

    pub fn close(self: *CFile) void {
        if (self.handle) |h| {
            _ = fclose(h);
            self.handle = null;
        }
    }

    pub fn write(self: CFile, msg: []const u8) void {
        if (self.handle) |h| {
            const c_msg = std.heap.c_allocator.dupeZ(u8, msg) catch return;
            defer std.heap.c_allocator.free(c_msg);
            _ = fprintf(h, "%s", c_msg.ptr);
        }
    }
};

pub fn main() !void {
    var file = try CFile.open("teste.txt", .write);
    defer file.close();

    file.write("Escrevendo via wrapper Zig!\n");
}