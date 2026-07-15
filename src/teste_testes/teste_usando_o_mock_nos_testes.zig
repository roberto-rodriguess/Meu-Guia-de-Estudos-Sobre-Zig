const std = @import("std");
const http = @import("teste_mocking.zig");

pub fn WeatherService(comptime Client: type) type {
    return struct {
        client: http.HttpClient(Client),

        pub fn getTemperature(self: @This(), allocator: std.mem.Allocator, city: []const u8) !f32 {
            // Agora usamos o allocator passado por parâmetro
            const url = try std.fmt.allocPrint(
                allocator, "https://api.weather.com/{s}", .{city}
            );
            defer allocator.free(url);

            const response = try self.client.get(url);
            // Parse JSON e extrai temperatura...
            _ = response;
            return 25.5;
        }
    };
}

// ============ TESTES ============
const testing = std.testing;

test "WeatherService com mock" {
    var mock = http.MockHttpClient.init(testing.allocator);
    defer mock.deinit();

    try mock.addResponse(
        "https://api.weather.com/SaoPaulo",
        "{\"temp\": 28.5}"
    );

    const client = http.HttpClient(http.MockHttpClient){
        .impl = mock
    };
    const service = WeatherService(http.MockHttpClient){
        .client = client
    };

    const temp = try service.getTemperature(testing.allocator, "SaoPaulo");
    try testing.expectApproxEqAbs(25.5, temp, 0.01);
}