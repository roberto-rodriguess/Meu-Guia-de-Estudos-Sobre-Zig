const std = @import("std");

// Importando o cabeçalho C do SQLite3
const c = @cImport({
    @cInclude("sqlite3.h");
});

const DatabaseError = error{
    OpenFailed,
    QueryFailed,
    PrepareFailed,
};

const Database = struct {
    db: ?*c.sqlite3,

    pub fn open(path: []const u8) DatabaseError!Database {
        var db: ?*c.sqlite3 = null;

        // No Zig 0.16.0, @ptrCast aceita APENAS 1 argumento (o ponteiro).
        // Especificamos o tipo de destino na própria variável const c_path.
        const c_path: [*c]const u8 = @ptrCast(path.ptr);

        const rc = c.sqlite3_open(c_path, &db);
        if (rc != c.SQLITE_OK) {
            std.debug.print("Erro ao abrir DB: {s}\n", .{c.sqlite3_errmsg(db)});
            return DatabaseError.OpenFailed;
        }

        return Database{ .db = db };
    }

    pub fn close(self: *Database) void {
        if (self.db) |db| {
            _ = c.sqlite3_close(db);
            self.db = null;
        }
    }

    // Corrigido retorno para DatabaseError!void (anteriormente estava Database!void)
    pub fn execute(self: *Database, sql: []const u8) DatabaseError!void {
        // Sintaxe corrigida do @ptrCast com 1 argumento
        const c_sql: [*c]const u8 = @ptrCast(sql.ptr);
        const rc = c.sqlite3_exec(self.db, c_sql, null, null, null);

        if (rc != c.SQLITE_OK) {
            return DatabaseError.QueryFailed;
        }
    }
};

pub fn main() !void {
    var db = try Database.open(":memory:");
    defer db.close();

    try db.execute(
        \\CREATE TABLE users (
        \\  id INTEGER PRIMARY KEY,
        \\  name TEXT NOT NULL
        \\);
    );

    try db.execute(
        \\INSERT INTO users (name) VALUES ('Alice'), ('Bob');
    );

    try db.execute(
        \\SELECT * FROM users;
    );

    std.debug.print("Banco de dados criado e tabela populada com sucesso!\n", .{});
}