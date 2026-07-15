const std = @import("std");

const DadoC = extern union {
    inteiro: c_int,
    flutuante: f32,
};

const DadoPacked = packed union {
    bits: u32,
    float: f32,
};

pub fn main() void {

}