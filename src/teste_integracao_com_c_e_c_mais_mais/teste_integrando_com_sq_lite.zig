const std = @import("std");

const c = @cImport({
    @cInclude("sqlite3.h");
});

pub const SQLiteError = error{
    OpenError,
    ExecError,
    PrepareError,
    StepError,
};

pub const Database = struct {
    db: ?*c.sqlite3,

    pub fn open(path: []const u8) !Database {
        const c_path = try std.heap.c_allocator.dupeZ(u8, path);
        defer std.heap.c_allocator.free(c_path);

        var db: ?*c.sqlite3 = null;
        const rc = c.sqlite3_open(c_path.ptr, &db);

        if (rc != c.SQLITE_OK or db == null) {
            return SQLiteError.OpenError;
        }

        return Database{ .db = db };
    }

    pub fn close(self: *Database) void {
        if (self.db) |db| {
            _ = c.sqlite3_close(db);
            self.db = null;
        }
    }

    pub fn execute(self: Database, sql: []const u8) !void {
        const c_sql = try std.heap.c_allocator.dupeZ(u8, sql);
        defer std.heap.c_allocator.free(c_sql);

        const rc = c.sqlite3_exec(self.db, c_sql.ptr, null, null, null);
        if (rc != c.SQLITE_OK) {
            return SQLiteError.ExecError;
        }
    }

    pub fn query(self: Database, sql: []const u8) !ResultSet {
        const c_sql = try std.heap.c_allocator.dupeZ(u8, sql);
        defer std.heap.c_allocator.free(c_sql);

        var stmt: ?*c.sqlite3_stmt = null;
        const rc = c.sqlite3_prepare_v2(
            self.db,
            c_sql.ptr,
            -1, // lê até null terminator
            &stmt,
            null
        );

        if (rc != c.SQLITE_OK or stmt == null) {
            return error.PrepareError;
        }
        return ResultSet{ .stmt = stmt};
    }
};

pub const ResultSet = struct {
    stmt: ?*c.sqlite3_stmt,

    pub fn deinit(self: *ResultSet) void {
        if (self.stmt) |stmt| {
            _ = c.sqlite3_finalize(stmt);
            self.stmt = null;
        }
    }

    pub fn next(self: ResultSet) !bool {
        if (self.stmt) |stmt| {
            const rc = c.sqlite3_step(stmt);
            if (rc == c.SQLITE_ROW) return true;
            if (rc == c.SQLITE_DONE) return false;
            return error.StepError;
        }
        return false;
    }

    pub fn getInt(self: ResultSet, col: c_int) i32 {
        if (self.stmt) |stmt| {
            return c.sqlite3_column_int(stmt, col);
        }
        return 0;
    }

    pub fn getText(self: ResultSet, col: c_int) []const u8 {
        if (self.stmt) |stmt| {
            const ptr = c.sqlite3_column_text(stmt, col);
            const len = c.sqlite3_column_bytes(stmt, col);
            if (ptr == null or len == 0) return "";
            return ptr[0..@intCast(len)];
        }
        return "";
    }
};

pub fn main() !void {
    // Cria/abre banco
    var db = try Database.open("texte.db");
    defer db.close();

    // Cria tabela
    try db.execute(
        \\CREATE TABLE IF NOT EXISTS users (
        \\    id INTEGER PRIMARY KEY,
        \\    name TEXT NOT NULL,
        \\    age INTEGER
        \\)
    );

    // Insere dados
    try db.execute(
        \\INSERT OR IGNORE INTO users (id, name, age)
        \\VALUES (1, 'João', 30), (2, 'Maria', 25)
    );

    // Query
    var result = try db.query("SELECT id, name, age FROM users");
    defer result.deinit();

    std.debug.print("Usuários:\n", .{});
    while (try result.next()) {
        const id = result.getInt(0);
        const name = result.getText(1);
        const age = result.getInt(2);

        std.debug.print("  {d}: {s} ({d} anos)\n", .{id, name, age});
    }
}
