// Simulando uma biblioteca C que chama callbacks
#pragma once
typedef void (*ProgressCallback)(int percent, void* user_data);
void do_work(ProgressCallback cb, void* user_data);
