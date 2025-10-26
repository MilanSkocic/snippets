#include <stdio.h>
#include <stdlib.h>
#if defined(_MSC_VER)
FILE * popen(const char *command, const char mode){
    return _popen(command, mode);
}
int pclose(FILE *stream){
    _pclose(stream);
}
#endif

int main(int argc, char **argv){

    FILE *f;
    int i;
    double *X;
    int N=3;
    X = (double *) calloc(N, sizeof(double));

    // run sequentially commands to gnuplot
    f = popen("gnuplot -persistent", "w");
    fprintf(f, "set title 'TITLE' font 'Arial, 16'\n");
    fprintf(f, "set xlabel 'xlabel /unit' font 'Arial, 14'\n");
    fprintf(f, "set tics font 'Arial, 14'\n");
    fprintf(f, "set grid\n");
    fprintf(f, "plot '-' w d dt 2 lw 2 lc 2 pt 6\n");
    for(i=0; i<N; i++){
        fprintf(f, "%d %f\n", i, *(X+i));
    }
    fprintf(f, "e\n");

    pclose(f);
}