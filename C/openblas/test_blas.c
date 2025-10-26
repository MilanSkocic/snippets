#include <stdio.h>
#include <stdlib.h>
#if defined(_MSC_VER)
#include <time.h>
#include <sys/timeb.h>
struct timeval {
  long int tv_sec;
  long int tv_usec;
}  ;
int gettimeofday (struct timeval *tp, void *tz)
{
struct _timeb timebuffer;
_ftime (&timebuffer);
tp->tv_sec = timebuffer.time;
tp->tv_usec = timebuffer.millitm * 1000;
return 0;
}
#else
#include <sys/time.h>
#endif

#if defined(__INTEL_COMPILER)
#include "mkl.h"
#else
#include "cblas.h"
#endif

// BLAS function implemented in fortran
extern void daxpy_(int *N, double *alpha, double *X, int *incX, double *Y, int *incY);
extern void dgemm_(char *TRANSA, char *TRANSB,
                    int *M, int *N, int *K,
                    double *ALPHA, double *A, int *LDA,
                    double *B, int *LDB, double *BETA, double *C, int *LDC);

int main()
{
    struct timeval start_t, end_t;
    double total_t;
    int N=1e8;
    int i, j;
    int m = 5;
    int k = 5;
    int n = 2;
    double alpha=1.0;
    int incX = 1;
    int incY = 1;
    double * restrict X;
    double * restrict Y;
    X = (double *) calloc(N, sizeof(double));
    Y = (double *) calloc(N, sizeof(double));
    double * restrict A = (double *) malloc(sizeof(double)*m*k);
    double * restrict B = (double *) malloc(sizeof(double)*k*n);
    double * restrict C = (double *) malloc(sizeof(double)*m*n);

    for (i=0; i<N; i++)
    {
        *(X+i) = 1.0;
    }

    // fill up A
    for (i=0;i<m; i++)
    {
        for (j=0;j<k; j++)
        {
            *(A+i*k+j) = i+j;
        }
    }

    // fill up B
    for (i=0;i<k; i++)
    {
        for (j=0;j<n; j++)
        {
            *(B+i*n+j) = i+j;
        }

    }

    // fill up C
    for (i=0;i<m; i++)
    {
        for (j=0;j<n; j++)
        {
            *(C+i*n+j) = i+j;
        }

    }

    //call blas directly
    printf("Call daxpy directly in BLAS: ");
    gettimeofday(&start_t, NULL);
    daxpy_(&N, &alpha, X, &incX, Y, &incY);
    gettimeofday(&end_t, NULL);
    total_t = (double) (end_t.tv_sec - start_t.tv_sec) *1e3
        + (end_t.tv_usec - start_t.tv_usec)*1e-3;
    printf("%.1f ms -  N=%d\n", total_t, N);

    // call cblas
    printf("Call daxpy through in CBLAS: ");
    gettimeofday(&start_t, NULL);
    cblas_daxpy(N, alpha, X, incX, Y, incY);
    gettimeofday(&end_t, NULL);
    total_t = (double) (end_t.tv_sec - start_t.tv_sec) *1e3
        + (end_t.tv_usec - start_t.tv_usec)*1e-3;
    printf("%.1f ms -  N=%d\n", total_t, N);

    char TRANSA = 'N';
    char TRANSB = 'N';
    double ALPHA = 0.1;
    double BETA = 2.21;

    // read row major memory with column major algorithm
    // comes to read the transpose of the matrix
    // dgemm => C = A.axB + bxC
    // we send a row major memory into Fortran code (col major)
    // which mean we are reading the transposes
    // dgemm_ => C* = axB*.A*+C*
    // LDA, LDB, LDC corresponds to the number of strides to move for the next line in row major
    // which also gives the number of strides to move to the next col in col major which (transpose)
    // C = [X11 X12 X13]
    //     [X21 X22 X23]
    // C* = [X11 X12]
    //      [X12 X22]
    //      [X13 X23]
    // In memory both are contiguous arrays: X11 X12 X13 X21 X22 X23
    // Reading in row major convention gives C (2x3)
    // Reading in col major convention gives C* (3*2)
    // common stride is 3 (number of cols in row major and number of rows in col major).
    // Normal call to dgemm with fortran would be
    // LDA = m if TRANSA = N and LDA = k if TRANSA = T
    // LDB = k if TRANSB = N and LDB = n if TRANSB = T
    // LDC = m if TRANSC = N and LDC = n if TRANSC = T
    // dgemm(TRANSA, TRANSB,
    //                M, N, K,
    //                ALPHA, A, LDA,
    //                B, LDB, BETA, C, LDC);

    // A and B are inversed in the call as we are dealing with the transposes 
    // du to the row major memory layout which corresponds
    // therefore LDA, LDB, LDC corresponds to the value when TRANSA, TRANSB and TRANSC are equal to T
    int LDA = k;
    int LDB = n;
    int LDC = n;
    dgemm_(&TRANSA, &TRANSB,
                    &n, &m, &k,
                    &ALPHA, B, &LDB,
                    A, &LDA, &BETA, C, &LDC);

    // print C
    printf("\n");
    for (i=0;i<m; i++)
    {
        for (j=0;j<n; j++)
        {
            printf("%f\t", *(C+i*n+j));
            *(C+i*n+j) = i+j;
        }
        printf("\n");
    }
     LDA = k;
     LDB = n;
     LDC = n;

    // CBLAS takes care of row major column memeory layout in C vs column major memory layout in Fortran.
    // CBLAS will inverse A and B but LDA, LDB and LDC must be set to the values when TRANSX = T
    // When it is possible it is easier to use CBLAS from C program.
     cblas_dgemm(CblasRowMajor, CblasNoTrans,
                 CblasNoTrans, m, n,
                 k, ALPHA, A,
                 LDA, B, LDB,
                 BETA, C, LDC);


    // print C
    printf("\n");
    for (i=0;i<m; i++)
    {
        for (j=0;j<n; j++)
        {
            printf("%f\t", *(C+i*n+j));
        }
        printf("\n");
    }

    return 0;
}
