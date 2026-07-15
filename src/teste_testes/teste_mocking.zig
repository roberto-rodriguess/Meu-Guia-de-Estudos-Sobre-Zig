const std = @import("std");

// Define uma interface genérica para HTTP
pub fn HttpClient(comptime T: type) type {
    return struct {
        impl: T,

        pub fn get(self: @This(), url: []const u8) ![]const u8 {
            return self.impl.get(url);
        }
    };
}

// Implementação real
pub const RealHttpClient = struct {
    allocator: std.mem.Allocator,

    pub fn get(self: RealHttpClient, url: []const u8) ![]const u8 {
        // Faz requisição HTTP real
        _ = self;
        _ = url;
        return "{\"status\":\"ok\"}";
    }
};

// Implementação mock para testes
pub const MockHttpClient = struct {
    responses: std.StringHashMap([]const u8),

    pub fn init(allocator: std.mem.Allocator) MockHttpClient {
        return .{
            .responses = std.StringHashMap([]const u8).init(allocator),
        };
    }

    pub fn deinit(self: *MockHttpClient) void {
        self.responses.deinit();
    }

    pub fn addResponse(self: *MockHttpClient, url: []const u8, response: []const u8) !void {
        try self.responses.put(url, response);
    }

    pub fn get(self: MockHttpClient, url: []const u8) ![]const u8 {
        return self.responses.get(url) orelse error.NotFound;
    }
};
