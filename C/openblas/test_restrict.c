#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

void fill(double *x, double value, size_t N){
    size_t i;
    for(i=0; i<N; i++){
        x[i] = value;
    }
}

void fillr(double  * restrict x, double value, size_t N){
    size_t i;
    for(i=0; i<N; i++){
        x[i] = value;
    }
}

int main(int argc, char **argv){

    size_t N = 100000000;
    double total_t;
    struct timeval start_t, end_t;
    double * x = (double *)malloc(sizeof(double)*N);

    gettimeofday(&start_t, NULL);
    fill(x, 2.0, N);
    gettimeofday(&end_t, NULL);
    total_t = (double) (end_t.tv_sec - start_t.tv_sec)*1e3
        + (end_t.tv_usec - start_t.tv_usec)*1e-3;
    printf("%.1e us -  N=%ld\n", total_t, N);

    gettimeofday(&start_t, NULL);
    fillr(x, 2.0, N);
    gettimeofday(&end_t, NULL);
    total_t = (double) (end_t.tv_sec - start_t.tv_sec) *1e3
        + (end_t.tv_usec - start_t.tv_usec)*1e-3;
    printf("%.1e us -  N=%ld\n", total_t, N);

    free(x);

    return EXIT_SUCCESS;
}