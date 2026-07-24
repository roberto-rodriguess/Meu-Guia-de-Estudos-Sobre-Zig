// clog.h
#ifndef CLOG_H
#define CLOG_H

typedef enum {
    LOG_DEBUG = 0,
    LOG_INFO = 1,
    LOG_WARN = 2,
    LOG_ERROR = 3
} LogLevel;

typedef struct Logger Logger;

Logger* logger_new(const char* name, LogLevel min_level);
void logger_free(Logger* logger);
void logger_log(Logger* logger, LogLevel level, const char* message);
void logger_set_level(Logger* logger, LogLevel level);

#endif
