#define PY_SSIZE_T_CLEAN
#include <Python.h>

PyDoc_STRVAR(module_docstring, 
"This module provides an example of looping over lists or tuples at C level.");


static PyObject *fastiter_iter(PyObject *self, PyObject *args)
{
    PyObject *l;
    Py_ssize_t i, size;
    PyObject * item;

    /* Parse the input tuple */
    if (!PyArg_ParseTuple(args, "O", &l))
        return NULL;
    size = PySequence_Size(l);
    for(i=0; i<size;i++){
        item = PySequence_GetItem(l, i);
        PySequence_SetItem(l, i, PyNumber_InPlaceMultiply(item, item));
    }

    Py_RETURN_NONE;
}


static PyMethodDef myMethods[] = {
    { "iter", (PyCFunction) fastiter_iter, METH_VARARGS, NULL},
    { NULL, NULL, 0, NULL }
};

// Our Module Definition struct
static struct PyModuleDef fastiter = {
    PyModuleDef_HEAD_INIT,
    "fastiter",
    module_docstring,
    -1,
    myMethods
};

// Initializes our module using our above struct
PyMODINIT_FUNC PyInit_fastiter(void)
{
    PyObject *m;
    PyObject *d;
    PyObject *v;

    m = PyModule_Create(&fastiter);

    d = PyModule_GetDict(m);
    
    v = PyFloat_FromDouble(3.14);

    PyDict_SetItemString(d, "PI", v);
    Py_INCREF(v);

    return m;
}


