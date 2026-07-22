#include "mylib.h"
#include <stdlib.h>
#include <string.h>

Point* point_create(int x, int y) {
    Point* p = malloc(sizeof(Point));
    if (p) {
        p->x = x;
        p->y = y;
        memset(p->name, 0, sizeof(p->name));
        p->user_data = NULL;
    }
    return p;
}

void point_destroy(Point* point) {
    free(point);
}

void point_move(Point* self, int dx, int dy) {
    if (self) {
        self->x += dx;
        self->y += dy;
    }
}
