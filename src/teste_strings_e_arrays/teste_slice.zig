const std = @import("std");

pub fn main() void {
    const array = [_]i32 { 0, 1, 2, 3, 4, 5 };

    const slice = array[1..4];

    std.debug.print("Slice: {any}\n", .{slice});
    std.debug.print("Tamanho: {d}\n", .{slice.len});
    std.debug.print("Primeiro elemento: {d}\n", .{slice[0]});

    const slice1 = array[0..3]; // [0, 1, 2]
    const slice2 = array[2..];  // [2, 3, 4, 5] (do índice 2 até o final)
    const slice3 = array[0..3]; // [0, 1, 2] (do início até índice 3)
    const slice4 = array[0..array.len]; // slice completo
}
