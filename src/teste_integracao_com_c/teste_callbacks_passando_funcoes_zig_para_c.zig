const std = @import("std");
const c = @cImport({
    @cInclude("stdlib.h");
});

// Função de comparação para qsort
fn compareInts(a: ?*const anyopaque, b: ?*const anyopaque) callconv(.c) c_int {
    const a_int: *const c_int = @ptrCast(@alignCast(a));
    const b_int: *const c_int = @ptrCast(@alignCast(b));

    if (a_int.* < b_int.*) return -1;
    if (a_int.* > b_int.*) return 1;

    return 0;
}

pub fn main() void {
    var nums = [_]c_int { 5, 2, 8, 1, 9, 3 };
    
    c.qsort(
        &nums,
        nums.len,
        @sizeOf(c_int),
        compareInts
    );

    for (nums) |n| {
        std.debug.print("{d} ", .{n});
    }
}
