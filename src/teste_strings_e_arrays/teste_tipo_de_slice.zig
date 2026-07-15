const std = @import("std");

pub fn main() void {
    // Slice de elementos constantes (mais comum)
    const slice_const: []const i32 = &[_]i32 {1, 2, 3};

    // Slice mutável (pode modificar elementos)
    var array_mut = [_]i32 {1, 2, 3};
    const slice_mut: []i32 = array_mut[0..];

    // Slice null-terminated (para interoperabilidade com C)
    const slice_nt: [:0]const u8 = "hello";
}
