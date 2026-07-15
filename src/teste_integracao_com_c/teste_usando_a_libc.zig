const std = @import("std");

// Importando a Libc diretamente
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("string.h");
    @cInclude("math.h");
    @cInclude("time.h"); // Adicionado para garantir o c.time
});

pub fn main() !void {
    // printf
    _ = c.printf("=== Testando Libc === \n");

    // malloc/free
    const ptr = c.malloc(100);
    // Em versões recentes, o retorno do malloc deve ser tratado como opcional
    if (ptr == null) {
        return error.OutOfMemory;
    }
    // Liberamos a memória usando o ponteiro opaco desembrulhado
    defer c.free(ptr);

    // strcpy: Convertendo o ponteiro usando @ptrCast de forma explícita
    const msg: [*c]u8 = @ptrCast(ptr);
    _ = c.strcpy(msg, "Olá do Zig!");
    _ = c.printf("Mensagem: %s \n", msg);

    // funções matemáticas
    const raiz = c.sqrt(2.0);
    _ = c.printf("Raiz de 2: %f \n", raiz);

    // random - o cast para c.time(null) precisa tratar o argumento como nulo do C
    c.srand(@intCast(c.time(null)));
    const aleatorio = c.rand();
    _ = c.printf("Número aleatório: %d \n", aleatorio);
}
