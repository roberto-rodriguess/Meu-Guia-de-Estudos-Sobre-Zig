const std = @import("std");

const Status = enum {ativo, inativo};

const s: Status = .ativo;
// é o mesmo que
const s2 = Status.ativo;

const Valor = union(enum) {numero: i32, texto: []const u8};

const v: Valor = .{.numero = 42};