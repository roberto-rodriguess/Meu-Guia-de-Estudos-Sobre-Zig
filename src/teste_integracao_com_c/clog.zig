// Wrapper Zig Idiomático
const std = @import("std");
const c = @cImport({
    @cInclude("clog.h");
});

pub const Level = enum(c_int) {
    debug = c.LOG_DEBUG,
    info = c.LOG_INFO,
    warn = c.LOG_WARN,
    err = c.LOG_ERROR,
};

pub const Logger = struct {
    raw: *c.Logger,
    name: []const u8,

    const Self = @This();

    pub fn new(name: []const u8, min_level: Level) !Self {
        const c_name: [*c]const u8 = @ptrCast(name.ptr);
        // name já é [:0]const u8, então name.ptr coerge diretamente para [*c]const u8
        const raw = c.logger_new(c_name, @intCast(@intFromEnum(min_level)));

        if (raw == null) return error.OutOfMemory;

        return Self {
            .raw = raw.?,
            .name = name,
        };
    }

    pub fn deinit(self: Self) void {
        c.logger_free(self.raw);
    }

    pub fn log(self: Self, level: Level, comptime fmt: []const u8, args: anytype) void {
        var buf: [1024]u8 = undefined;
        // Concatena com \x00 no comptime para garantir o terminador nulo para o C
        const message = std.fmt.bufPrint(&buf, fmt ++ "\x00", args) catch |errr| {
            std.debug.print("Erro ao formatar log: {}\n", .{errr});
            return;
        };

        const c_msg: [*c]const u8 = @ptrCast(message.ptr);
        c.logger_log(self.raw, @intCast(@intFromEnum(level)), c_msg);
    }

    pub fn debug(self: Self, comptime fmt: []const u8, args: anytype) void {
        self.log(.debug, fmt, args);
    }

    pub fn info(self: Self, comptime fmt: []const u8, args: anytype) void {
        self.log(.info, fmt, args);
    }

    pub fn warn(self: Self, comptime fmt: []const u8, args: anytype) void {
        self.log(.warn, fmt, args);
    }

    pub fn err(self: Self, comptime fmt: []const u8, args: anytype) void {
        self.log(.err, fmt, args);
    }

    pub fn setLevel(self: Self, level: Level) void {
        c.logger_set_level(self.raw, @intCast(@intFromEnum(level)));
    }
};
