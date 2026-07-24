#include "clog.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Logger {
    char* name;
    LogLevel min_level;
};

Logger* logger_new(const char* name, LogLevel min_level) {
    Logger* logger = (Logger*)malloc(sizeof(Logger));
    if (!logger) return NULL;

    logger->name = (char*)malloc(strlen(name) + 1);
    if (!logger->name) {
        free(logger);
        return NULL;
    }
    strcpy(logger->name, name);

    logger->min_level = min_level;
    return logger;
}

void logger_free(Logger* logger) {
    if (logger) {
        free(logger->name);
        free(logger);
    }
}

void logger_log(Logger* logger, LogLevel level, const char* message) {
    if (!logger) return;
    if (level < logger->min_level) return;

    const char* level_str = "UNKNOWN";
    switch (level) {
        case LOG_DEBUG: level_str = "DEBUG"; break;
        case LOG_INFO:  level_str = "INFO";  break;
        case LOG_WARN:  level_str = "WARN";  break;
        case LOG_ERROR: level_str = "ERROR"; break;
    }

    printf("[%s] (%s): %s\n", level_str, logger->name, message);
}

void logger_set_level(Logger* logger, LogLevel level) {
    if (logger) {
        logger->min_level = level;
    }
}
