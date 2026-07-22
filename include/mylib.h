#pragma once
typedef struct {
    int x;
    int y;
    char name[64];
    void* user_data;
} Point;

Point* point_create(int x, int y);
void point_destroy(Point* point);
void point_move(Point* self, int dx, int dy);
