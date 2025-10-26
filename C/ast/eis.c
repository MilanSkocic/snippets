#include <stdio.h>
#include <math.h>
#include <complex.h>
#include "eis.h"

double complex resistance(double *p, double w){
    return (double complex) p[0];
}

double complex capacitance(double *p, double w){
    return 1/(I*w*p[0]);
}

double complex inductance(double *p, double w){
    return I*p[0]*w;
}

double complex cpe(double *p, double w){
    return 1/(p[0]*cpow(w*I, p[1]));
}

double complex warburg(double *p, double w){
    return p[0] / sqrt(w) * (1-I);
}

double complex finite_length_warburg(double *p, double w){
    return p[0]*ctanh(cpow(I*p[1]*w, p[2])) / cpow(I*p[1]*w, p[2]);
}

double complex finite_space_warburg(double *p, double w){
    return p[0]/(ctanh(cpow(I*p[1]*w, p[2])) * cpow(I*p[1]*w, p[2]));
}


char *eval_test(char *value){

    /* printf("TOKEN EVAL VALUE = %s\n", value); */
    return value;

}
