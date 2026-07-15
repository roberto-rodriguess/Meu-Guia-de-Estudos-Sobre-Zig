const std = @import("std");

const c = @import("std").c;

pub extern "c" fn @"erro"() void;
pub extern "c" fn @"fstat$INODE64"(fd: c.fd_t, buf: *c.Stat) c_int;

pub fn main() void {
    const @"identificador com espacos" = 0xff;

    c.printf("%d", @"identificador com espacos");
}
