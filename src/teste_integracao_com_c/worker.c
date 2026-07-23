#include "worker.h"

#ifdef _WIN32
#include <windows.h>
#define sleep_ms(ms) Sleep(ms)
#else
#include <unistd.h>
#define sleep_ms(ms) usleep((ms) * 1000)
#endif

void do_work(ProgressCallback cb, void* user_data) {
    for (int i = 0; i <= 100; i += 25) {
        if (cb) {
            cb(i, user_data);
        }
        sleep_ms(100); // Simula trabalho demorado
    }
}
