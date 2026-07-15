const std = @import("std");

const Resultado = struct {};

fn processarEntrada(entrada: []const u8) !Resultado {
    if (entrada.len == 0) return error.EntradaVazia;
    if (entrada.len > 1000) return error.EntradaMuitoGrande;

    const parseado = try parse(entrada);
    const validado = try validar(parseado);

    return try transformar(validado);
}

fn parse(e: []const u8) !i32 {_ = e; return 0;}
fn validar(x: i32) i32 {_ = x; return 0;}
fn transformar(x: i32) !Resultado {_ = x; return Resultado{};}