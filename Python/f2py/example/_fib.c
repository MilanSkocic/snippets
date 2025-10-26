#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "numpy/arrayobject.h"
#include "numpy/ndarraytypes.h"
#include "numpy/npy_math.h"
#include "fib.h"

PyDoc_STRVAR(module_docstring, "This module provides an example of interfacing C.");

PyDoc_STRVAR(fib_docstring, "a=fib(n)\nCompute the fibonacci serie with input array from the array module. Avoid compilation with Numpy");



static PyObject *fibc_fib(PyObject *self, PyObject *args)
{
    Py_ssize_t n;
    
    /* Parse the input tuple */
    if (!PyArg_ParseTuple(args, "n", &n))
        return NULL;

    /*Create a new ZEROS ARRAY for output*/
    PyArrayObject *new_array = (PyArrayObject *)PyArray_ZEROS(1, &n, NPY_INT, 0);

    /* cast and pass buffer and shape */
    fib_c_code((npy_int *) PyArray_DATA(new_array), n);

    return PyArray_Return(new_array);

}

static PyMethodDef myMethods[] = {
    { "fib", (PyCFunction) fibc_fib, METH_VARARGS, fib_docstring },
    { NULL, NULL, 0, NULL }
};

// Our Module Definition struct
static struct PyModuleDef fib_c = {
    PyModuleDef_HEAD_INIT,
    "fib_c",
    module_docstring,
    -1,
    myMethods
};

// Initializes our module using our above struct
PyMODINIT_FUNC PyInit_fib_c(void)
{
	import_array();
    return PyModule_Create(&fib_c);
}


