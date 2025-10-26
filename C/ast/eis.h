#ifndef EIS_H
#define EIS_H

#include<math.h>
#include<complex.h>

double complex resistance(double *p, double w);

double complex capacitance(double *p, double w);

double complex inductance(double *p, double w);

double complex cpe(double *p, double w);

double complex warburg(double *p, double w);

double complex finite_length_warburg(double *p, double w);

double complex finite_space_warburg(double *p, double w);

char *eval_test(char *value);

#endif
