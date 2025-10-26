#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>
#include <string.h>
#include "mandelbrot_core.h"

PyDoc_STRVAR(module_docstring, "C extension wrapping the mandelbrot module of the Fortran library.");

static PyMethodDef myMethods[] = {
    { NULL, NULL, 0, NULL }
};

// Our Module Definition struct
static struct PyModuleDef core = {
    PyModuleDef_HEAD_INIT,
    "core",
    module_docstring,
    -1,
    myMethods
};

// Initializes our module using our above struct
PyMODINIT_FUNC PyInit_core(void)
{
    return PyModule_Create(&core);
}


