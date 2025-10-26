#cython: language_level=3
import numpy as np
cimport numpy as np
import cython

cdef extern from "chi2.h":
    double chi2(double m, double b, double *x, double *y, double *yerr, int N)  # z = a + b

@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
def cython_chi2(double m, double b, double[:] x, double[:] y, double[:] yerr, int N):
    r"""
    Calculate the chi-squared of some data given a model.

    Parameters
    -------------
    m: float
        Slope
    b: float
        Intercept
    x: array-like
        Object supporting memoryview
    y: array-like
        Object supporting memoryview
    yerr: array-like
        Object supporting memoryview
    N: int
        Array size

    Returns
    -----------
    chi2: float
        Chi2 value
    """
    cdef int n=0
    cdef double result = 0.0
    cdef double diff=0.0

    for n in range(N):
        diff = (y[n] - (m * x[n] + b)) / yerr[n]
        result += diff * diff

    return result


@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
def cython_wrap_chi2(double m, double b, double[:] x, double[:] y, double[:] yerr, int N):
    r"""
    Wrapper of C code. Calculate the chi-squared of some data given a model.

    Parameters
    -------------
    m: float
        Slope
    b: float
        Intercept
    x: array-like
        Object supporting memoryview
    y: array-like
        Object supporting memoryview
    yerr: array-like
        Object supporting memoryview
    N: int
        Array size

    Returns
    -----------
    chi2: float
        Chi2 value
    """
    return chi2(m, b, &x[0], &y[0], &yerr[0], N)