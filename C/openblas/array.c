#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#if defined(__INTEL_COMPILER)
#include "mkl.h"
#else
#include "cblas.h"
#endif

typedef enum {
    CHAR,
    INT,
    FLOAT,
    DOUBLE
}TYPE;

typedef struct ndarray {
    char *data;
    long int *strides;
    long int *shape;
    long int nbytes;
    int itemsize;
    long int size;
    int ndim;
    void (*display)(struct ndarray *);
}ndarray;


void display(ndarray *array);
ndarray *create_ndarray(int ndim, long int *shape, int itemsize);
void free_ndarray(ndarray *array);
void inner_loop(char *x, long int *shape, long int *strides, long int ndim, int n,
void (*func)(char *));
void print_value(char *x);


int main(int argc, char **argv)
{
    int ndim = 2;

    long int *shape = calloc(ndim, sizeof(long int));
    shape[0] = 2;
    shape[1] = 5;
    ndarray *array = create_ndarray(ndim, shape, sizeof(double));


    array->display(array);
    cblas_dscal(array->size, 2, (double *)array->data, 1);
    array->display(array);

    free_ndarray(array);

    return 0;
}

void display(ndarray *array){

    int n = 0;
    inner_loop(array->data, array->shape, array->strides, array->ndim, n, &print_value);
}

void print_value(char *x){
    printf("%f\t", *(double *)x);
}


void inner_loop(char *x, long int *shape, long int *strides, long int ndim, int n, void (*func)(char *)){

    int i;

    for (i=0; i<shape[n]; i++){

        if ((n+1)<ndim)
        {
            inner_loop(x+i*strides[n], shape, strides, ndim, n+1, func);
        }
        else
        {
             (*func)(x+i*strides[n]);
        }

    }
    printf("\n");
}

ndarray *create_ndarray(int ndim, long int *shape, int itemsize){

    long int i, j;
    long int nbytes=1;
    long int size = 1;
    long int *strides = calloc(ndim, sizeof(long int));

    for (i=0; i<ndim; i++)
    {
        size = *(shape+i) * size;
        *(strides+i) = itemsize;
        for (j=i+1; j<ndim; j++){
            *(strides+i) = *(strides+i) * *(shape+j);
        }
    }
    nbytes = size * itemsize;

    ndarray *array = (ndarray *) malloc(sizeof(ndarray));


    array->data = (char *)calloc(nbytes, sizeof(char));
    *(double *) array->data = 1;
    *(double *) (array->data+1*strides[1]) = 1.3;
    *(double *) (array->data+1*strides[0]) = 1.9;
    array->ndim = ndim;
    array->shape = shape;
    array->nbytes = nbytes;
    array->size = size;
    array->itemsize = itemsize;
    array->strides = strides;
    array->display = &display;


    return array;
}

void free_ndarray(ndarray *array){

    free(array->data);
    free(array->strides);
    free(array->shape);
    free(array);

}

