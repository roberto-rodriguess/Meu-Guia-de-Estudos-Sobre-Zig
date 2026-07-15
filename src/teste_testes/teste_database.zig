
const std = @import("std");
const Allocator = std.mem.Allocator;

/// Estrutura que representa o Usuário no sistema
pub const User = struct {
    id: u32,
    name: []const u8,
    email: []const u8,
};

/// Estrutura para os dados de criação/atualização
pub const UserConfig = struct {
    name: []const u8,
    email: ?[]const u8 = null,
};

pub const Database = struct {
    allocator: Allocator,
    // Usamos um Map em memória para simular o banco de dados do exemplo
    users: std.AutoHashMap(u32, User),
    next_id: u32,

    const Self = @This();

    /// Inicializa a conexão com o banco (no exemplo, aceita um path ou ":memory:")
    pub fn init(allocator: Allocator, connection_string: []const u8) !Self {
        _ = connection_string; // Em um banco real, usaríamos isso aqui

        return Self{
            .allocator = allocator,
            .users = std.AutoHashMap(u32, User).init(allocator),
            .next_id = 1,
        };
    }

    /// Libera os recursos alocados pelo banco de dados
    pub fn deinit(self: *Self) void {
        var it = self.users.iterator();
        while (it.next()) |entry| {
            self.allocator.free(entry.value_ptr.name);
            self.allocator.free(entry.value_ptr.email);
        }
        self.users.deinit();
    }

    /// Cria um novo usuário e retorna o ID gerado
    pub fn createUser(self: *Self, config: UserConfig) !u32 {
        const id = self.next_id;

        // Duplica as strings para garantir que o banco seja dono dos dados em memória
        const duplicated_name = try self.allocator.dupe(u8, config.name);
        errdefer self.allocator.free(duplicated_name);

        const duplicated_email = try self.allocator.dupe(u8, config.email orelse "");
        errdefer self.allocator.free(duplicated_email);

        const user = User{
            .id = id,
            .name = duplicated_name,
            .email = duplicated_email,
        };

        try self.users.put(id, user);
        self.next_id += 1;

        return id;
    }

    /// Busca um usuário pelo ID. Retorna erro caso não encontre
    pub fn getUser(self: Self, id: u32) !User {
        return self.users.get(id) orelse return error.UserNotFound;
    }

    /// Atualiza os dados de um usuário existente
    pub fn updateUser(self: *Self, id: u32, config: UserConfig) !void {
        var user = self.users.get(id) orelse return error.UserNotFound;

        // Atualiza o nome se fornecido
        const old_name = user.name;
        user.name = try self.allocator.dupe(u8, config.name);
        self.allocator.free(old_name);

        // Atualiza o email se fornecido na configuração
        if (config.email) |new_email| {
            const old_email = user.email;
            user.email = try self.allocator.dupe(u8, new_email);
            self.allocator.free(old_email);
        }

        try self.users.put(id, user);
    }

    /// Deleta um usuário do banco de dados
    pub fn deleteUser(self: *Self, id: u32) !void {
        const user = self.users.get(id) orelse return error.UserNotFound;

        // Libera a memória antes de remover do Map
        self.allocator.free(user.name);
        self.allocator.free(user.email);

        _ = self.users.remove(id);
    }
};

const TestContext = struct {
    db: Database,
    allocator: std.mem.Allocator,

    fn init(allocator: std.mem.Allocator) !TestContext {
        var ctx: TestContext = undefined;
        ctx.allocator = allocator;
        ctx.db = try Database.init(allocator, ":memory");
        return ctx;
    }

    fn deinit(self: *TestContext) void {
        self.db.deinit();
    }
};

pub fn main(init: std.process.Init) !void {
    var ctx = try TestContext.init(init.gpa);
    defer ctx.deinit();

    const user_id = try ctx.db.createUser(.{
        .name = "João Silva",
        .email = "joao@exemplo.com",
    });

    const user = try ctx.db.getUser(user_id);

    std.debug.print("Usuário: {s}\n{s}\n", .{user.name, user.email});

    // Atualiza usuário
    try ctx.db.updateUser(user_id, .{.name = "João S."});

    std.debug.print("Usuário: {s}\n{s}\n", .{user.name, user.email});
}