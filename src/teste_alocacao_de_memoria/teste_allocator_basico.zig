const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    const arr = try allocator.alloc(i32, 100);
    defer allocator.free(arr);

    arr[0] = 43;

    var i: usize = 0;
    while(i < 1000) : (i += 1) {
        std.debug.print("{d} ", .{arr[i]});
    }
}
