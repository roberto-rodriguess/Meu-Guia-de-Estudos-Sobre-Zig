const std = @import("std");

// Gerar tabela de quadrados em comptime
fn gerarTabelaQuadrados(comptime tamanho: usize) [tamanho]u64 {
    var tabela: [tamanho]u64 = undefined;
    for (0..tamanho) |i| {
        tabela[i] = i * i;
    }
    return tabela;
}

// Gerar tabela de senos pré-calculados (para games/DSP)
fn gerarTabelaSenos(comptime pontos: usize) [pontos]f64 {
    var tabela: [pontos]f64 = undefined;
    const passo = 2.0 * std.math.pi / @as(f64, @floatFromInt(pontos));
    for (0..pontos) |i| {
        tabela[i] = @sin(passo * @as(f64, @floatFromInt(i)));
    }

    return tabela;
}

// Gerar tabela de senos pré-calculados (para games/DSP)
fn gerarCRC32Table() [256]u32 {
    var tabela: [256]u32 = undefined;
    for (0..256) |i| {
        var crc: u32 = @intCast(i);
        for (0..8) |_| {
            if (crc & 1 == 1) {
                crc = (crc >> 1) ^ 0xEDB88320;
            } else {
                crc = crc >> 1;
            }
        }
        tabela[i] = crc;
    }
    return tabela;
}

// Todas estas tabelas são calculadas em TEMPO DE COMPILAÇÃO
// e incorporadas ao binário como dados estáticos
const QUADRADOS = gerarTabelaQuadrados(100);
const SENOS = gerarTabelaSenos(360);
const CRC32_TABLE = gerarCRC32Table();

pub fn main() void {
    std.debug.print("7² = {}\n", .{QUADRADOS[7]}); // 49
    std.debug.print("sin(90°) ≈ {d:.6}\n", .{SENOS[90]}); // ~1.0
    std.debug.print("CRC32[0] = 0x{X:0>8}\n", .{CRC32_TABLE[0]}); // 0x00000000
    std.debug.print("CRC32[1] = 0x{X:0>8}\n", .{CRC32_TABLE[1]}); // 0x77073096
}