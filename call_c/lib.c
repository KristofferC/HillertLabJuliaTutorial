#include <stdio.h>

void axpy(double a, double x[], double y[], int len) {
    for (int i = 0; i < len; i++) {
        y[i] = a * x[i] + y[i];
    }
    printf("computiation in C done\n");
}
