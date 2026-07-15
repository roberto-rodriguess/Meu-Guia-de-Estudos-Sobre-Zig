const std = @import("std");
const testing = std.testing;

const database = @import("database");

const TestContext = struct {
    db: database.Database,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator) !TestContext {
        var ctx: TestContext = undefined;
        ctx.allocator = allocator;
        ctx.db = try database.Database.init(allocator, ":memory");
        return ctx;
    }

    fn deinit(self: *TestContext) void {
        self.db.deinit();
    }
};

test "ciclo completo de usuário" {
    var ctx = try TestContext.init(testing.allocator);
    defer ctx.deinit();

    // Cria usuário
    const user_id = try ctx.db.createUser(.{
        .name = "João Silva",
        .email = "joao@exemplo.com",
    });
    try testing.expect(user_id > 0);

    // Busca usuário
    const user = try ctx.db.getUser(user_id);
    try testing.expectEqualStrings("João Silva", user.name);
    try testing.expectEqualStrings("joao@exemplo.com", user.email);

    // Atualiza usuário
    try ctx.db.updateUser(user_id, .{.name = "João S."});
    const updated = try ctx.db.getUser(user_id);
    try testing.expectEqualStrings("João S.", updated.name);
}