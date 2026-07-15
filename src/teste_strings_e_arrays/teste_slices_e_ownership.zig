const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    var dados = [_]u8 { 'a', 'b', 'c', 'd', 'e' };

    // slice1 e slice2 referenciam o mesmo array
    const slice1 = dados[0..3];
    const slice2 = dados[2..5];

    // Modificando através de um slice afeta o array original
    dados[2] = 'X';

    print("slice1: {s}\n", .{slice1}); // "abX"
    print("slice2: {s}\n", .{slice2}); // "Xde"
}