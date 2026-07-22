const std = @import("std");
const c = @cImport({
    @cInclude("curl/curl.h");
});

// comando pra executar no terminal:
// zig run src/teste_integracao_com_c/teste_wrapping_uma_funcao_c.zig lib/libcurl.dll.a -lc -I include/

// Wrapper idiomático em Zig (mudado retorno para ![]const u8)
pub fn fetchUrl(allocator: std.mem.Allocator, url: []const u8) ![]const u8 {
    const curl = c.curl_easy_init();
    if (curl == null) return error.CurlInitFailed;
    defer c.curl_easy_cleanup(curl);

    // Converter URL para C string nulo-terminada (dupeZ adiciona o '\0' no final)
    const c_url = try allocator.dupeZ(u8, url);
    defer allocator.free(c_url);

    _ = c.curl_easy_setopt(curl, c.CURLOPT_URL, c_url.ptr);
    _ = c.curl_easy_setopt(curl, c.CURLOPT_FOLLOWLOCATION, @as(c_long, 1));

    // Executar
    const res = c.curl_easy_perform(curl);
    if (res != c.CURLE_OK) {
        return error.CurlRequestFailed;
    }

    return "Requisição realizada com sucesso";
}

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    const resultado = try fetchUrl(allocator, "https://www.google.com");
    std.debug.print("resultado: {s}\n", .{resultado});
}
