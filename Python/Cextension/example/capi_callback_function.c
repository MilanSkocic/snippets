#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "numpy/arrayobject.h"
#include "numpy/ndarraytypes.h"
#include "numpy/npy_math.h"
#include "optimizer.h"

PyDoc_STRVAR(module_docstring, "This module provides an example of calling a Python callback function from C Code."
"Usually used for wrapping function optimizers.");

PyDoc_STRVAR(optimizer_docstring, "Dummy optimizer. It does not perform any calculations. "
"optimizer(fcn, args)-> (fvec, xopt)");

static PyObject *py_fcn=NULL;/* Python callback function - borrowed reference */
static PyObject *fcn_args=NULL;/* passed from caller - borrowed references */
static PyObject *fcn_xargs=NULL;/* new_args = (x, *args) - stealed references */
static PyArrayObject *fvec_array=NULL;/* returned values from Python callback - owned reference */
static PyArrayObject *xopt_array=NULL;/* returned values from Python callback - owned reference */

static void printf_refcnt(const char *name, PyObject *o){
    printf("Refcount %s = %ld\n", name, Py_REFCNT(o));
}

/* C wrapper of the Python callback function
 * signature is dependent on the definition of cost function signature in the optimizer
 * the principle is to get C variable and update the Python variable passed as arguments to the Python callback */
void fcn(size_t m, size_t n, double *x, double *fvec){

    PyGILState_STATE state;
    Py_XDECREF(fvec_array);
    // lock GIL
    state = PyGILState_Ensure();
    fvec_array = (PyArrayObject *) PyObject_Call(py_fcn, fcn_xargs, NULL);
    PyGILState_Release(state);
    
}

/* Python wrapper of the C optimizer */
static PyObject *wrap_optimizer(PyObject *self, PyObject *args)
{
    size_t m, n, j, nargs;
    PyObject *item=NULL;
    PyGILState_STATE state;
    PyObject *res;
    PyArrayObject * p0_array=NULL;/* returned values from Python callback - owned reference */
    double *p0_array_ptr;
    double *xopt_array_ptr;
    npy_intp i;

    /* Parse the input tuple */
    if (!PyArg_ParseTuple(args, "OOO",&py_fcn, &p0_array, &fcn_args))
        return NULL;
    /* check if py_fcn is a callable */
    if (!PyCallable_Check(py_fcn)) {
        PyErr_SetString(PyExc_TypeError, "func must be callable");
        return NULL;
    }
    /* check if args is an iterable */
    if (!PyArray_Check(p0_array)){
        PyErr_SetString(PyExc_TypeError, "x0 must 1d array.");
        return NULL;
    }
    /* check if args is an iterable */
    if (!PySequence_Check(fcn_args)){
        PyErr_SetString(PyExc_TypeError, "args must be an iterable");
        return NULL;
    }

    if (!PyArray_ISFLOAT(p0_array)){
        PyErr_SetString(PyExc_TypeError, "x0 must of type double.");
        Py_XDECREF(p0_array);
        return NULL;
    }
    // copy p0 intp xopt.
    xopt_array = (PyArrayObject *) PyArray_ZEROS(PyArray_NDIM(p0_array), PyArray_DIMS(p0_array), NPY_FLOAT64, 0);
    for(i=0;i<PyArray_DIM(xopt_array, 0);i++){
        p0_array_ptr = (double *)((char *)PyArray_DATA(p0_array) + i*PyArray_STRIDE(p0_array, 0));
        xopt_array_ptr = (double *)((char *)PyArray_DATA(xopt_array) + i*PyArray_STRIDE(xopt_array, 0));
        *xopt_array_ptr = *p0_array_ptr;
    }

    // args = (p, *args) in Python
    // PyTuple_GetItem borrow a reference
    // PyTuple_SetItem steals a reference
    nargs = PySequence_Length(fcn_args)+1;
    fcn_xargs = PyTuple_New(nargs);
    Py_INCREF(xopt_array);
    PyTuple_SetItem(fcn_xargs, 0, (PyObject *) xopt_array);
    for (j=1; j<nargs; j++) {
        item = PyTuple_GetItem(fcn_args, j-1);
        Py_INCREF(item);
        PyTuple_SetItem(fcn_xargs, j, item);
    }
    /* get number of elements in array to be optimized */
    m = PyArray_DIM(xopt_array, 0);

    /* call callback function */
    // Lock GIL
    state = PyGILState_Ensure();
    fvec_array = (PyArrayObject *) PyObject_CallObject(py_fcn, fcn_xargs);
    PyGILState_Release(state);
    /* get number of elements in fvec_array */
    n = PyArray_DIM(fvec_array, 0);

    /* call optimizer
     * pass xopt_array pointer to data for the optimizer to work on */
    optimizer(&fcn, m, n,
                (double *)(PyArray_DATA(xopt_array)),
                    NULL);
    
    Py_XDECREF(fcn_xargs);

    return Py_BuildValue("OO", xopt_array, fvec_array);
}


// Methods definitons
static PyMethodDef myMethods[] = {
    { "wrap_optimizer", (PyCFunction) wrap_optimizer, METH_VARARGS, optimizer_docstring },
    { NULL, NULL, 0, NULL }
};

// Our Module Definition struct
static struct PyModuleDef capi_callback = {
    PyModuleDef_HEAD_INIT,
    "capi_callback",
    module_docstring,
    -1,
    myMethods
};

// Initializes our module using our above struct
PyMODINIT_FUNC PyInit_capi_callback(void)
{
    import_array();
    return PyModule_Create(&capi_callback);
}


