const std = @import("std");

pub fn main() void {
    const HeaderPacote = packed struct {
        versao: u4,
        flags: u4,
        tamnho: u16,
        checksum: u32,
    };

    comptime {
        std.debug.assert(@sizeOf(HeaderPacote) == 8);
    }
}
