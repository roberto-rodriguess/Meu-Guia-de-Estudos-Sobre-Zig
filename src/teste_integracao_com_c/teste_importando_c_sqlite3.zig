const std = @import("std");

// Importando o cabeçalho C do SQLite3
const c = @cImport({
    @cInclude("sqlite3.h");
});

pub fn main() !void {
    std.debug.print("=== Teste de Integração com SQLite 3 (C) ===\n", .{});
    
    // Imprime a versão da biblioteca SQLite em C
    const versao = c.sqlite3_libversion();
    std.debug.print("Versão do SQLite C: {s}\n", .{versao});

    var db: ?*c.sqlite3 = null;
    
    // Abre um banco de dados temporário na memória RAM (":memory:")
    const rc = c.sqlite3_open(":memory:", &db);
    if (rc != c.SQLITE_OK) {
        std.debug.print("Erro ao abrir banco de dados: {s}\n", .{c.sqlite3_errmsg(db)});
        return error.OpenFailed;
    }
    defer _ = c.sqlite3_close(db);

    std.debug.print("Banco de dados na memória aberto com sucesso!\n", .{});

    // Criando uma tabela simples
    const sql_create = "CREATE TABLE alunos (id INT, nome TEXT);";
    var err_msg: [*c]u8 = null;
    
    if (c.sqlite3_exec(db, sql_create, null, null, &err_msg) != c.SQLITE_OK) {
        std.debug.print("Erro ao criar tabela: {s}\n", .{err_msg});
        if (err_msg != null) c.sqlite3_free(err_msg);
        return error.QueryFailed;
    }

    std.debug.print("Tabela 'alunos' criada com sucesso!\n", .{});
}
