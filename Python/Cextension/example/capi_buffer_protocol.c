#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "fib.h"

PyDoc_STRVAR(module_docstring, 
"This module provides an example of interfacing with the buffer protocol at C level.");

PyDoc_STRVAR(fib_array_docstring, 
"Compute the fibonacci serie with input array from the array module. Avoid compilation with Numpy");

PyDoc_STRVAR(fib_mview_docstring, 
            "fib_new(n=1)->array\n\n"
            "Avoid compilation with Numpy");


static PyObject *mview_like(PyObject * mview){
    
    
    PyObject *new_mview;
    Py_buffer new_buffer;

    Py_buffer *buf = PyMemoryView_GET_BUFFER(mview);

    new_buffer.buf = PyMem_Malloc(buf->len);
    new_buffer.obj = NULL;
    new_buffer.len = buf->len;
    new_buffer.readonly = buf->readonly;
    new_buffer.itemsize = buf->itemsize;
    new_buffer.format = buf->format;
    new_buffer.ndim = buf->ndim;
    new_buffer.shape = buf->shape;
    new_buffer.strides = buf->strides;
    new_buffer.suboffsets = NULL;

    new_mview = PyMemoryView_FromBuffer(&new_buffer);

    PyBuffer_Release(&new_buffer);


    return new_mview;
}

static PyObject *capi_fibonacci_array_input(PyObject *self, PyObject *args)
{
    PyObject *array;
    PyObject *mview;
    Py_buffer *buffer;
    Py_ssize_t *shape;

    /* Parse the input tuple */
    if (!PyArg_ParseTuple(args, "O", &array))
        return NULL;
    if(PyObject_CheckBuffer(array) == 0){
        PyErr_SetString(PyExc_RuntimeError, "array must a be object exposing the buffer protocol.");
        return NULL;
    }
    /* Get memoryview and the associated buffer */
    mview = PyMemoryView_FromObject(array);
    buffer = PyMemoryView_GET_BUFFER(mview);

    if(PyBuffer_IsContiguous(buffer, 'C')==0){
        PyErr_SetString(PyExc_RuntimeError, "array is not C or F contiguous");
        return NULL;
    }
    if(PyBuffer_IsContiguous(buffer, 'F')==0){
        PyErr_SetString(PyExc_RuntimeError, "array is not C or F contiguous");
        return NULL;
    }
    shape = buffer->shape;

    /* cast and pass buffer and shape */
    fib((double *) buffer->buf, (int) *shape);

    return Py_BuildValue("O", array);
}

static PyObject *capi_fibonacci_new_array(PyObject *self, PyObject *args, PyObject *kwargs)
{
    Py_ssize_t n,i,size;
    static char *kwlist[] = {"n", NULL};
    n = 1;
    
    PyObject *new_mview;
    Py_buffer new_buffer;
    Py_ssize_t new_shape[2]= {0, 0};

    /* Parse the input tuple */
    if (!PyArg_ParseTupleAndKeywords(args, kwargs,  "|n", kwlist, &n))
        return NULL;
    
    // if C contiguous array with n dimensions:
    //     strides[n] = elmtsize
    //     strides[i] = elmtsize * prod(shape[j] for j=i+1 to n) where i=1 to n-1
    // if F contiguous array with n dimensions:
    //     strides[1] = elmtsize
    //     strides[i] = elmtsize * prod(shape[j] for j=1 to i-1) where i=2 to n
    Py_ssize_t strides[2] = {2*sizeof(double), sizeof(double)};

    new_shape[0] = n;
    new_shape[1] = 2;

    size = 1;
    for(i=0;i<2;i++){
        size *= new_shape[i];
    }

    /* Create a new buffer with the associated properties as struct members */
    /* adapt the creatioon the desired type */
    new_buffer.buf = PyMem_Calloc(size, sizeof(double));
    new_buffer.obj = NULL;
    new_buffer.len = size*sizeof(double);
    new_buffer.readonly = 0;
    new_buffer.itemsize = sizeof(double);
    new_buffer.format = "d";
    new_buffer.ndim = 2;
    new_buffer.shape = new_shape;
    new_buffer.strides = strides;
    new_buffer.suboffsets = NULL;

    /* create a memoryview from buffer.
    An advantage of returning the memory view instead of the
    buffer only is that the former is a Python object and can be used by Numpy
    If necessary to create an extension that creates n-dimensional c-contiguous buffers
    that can be used by Numpy without having to compile the extension with Numpy */
    new_mview = PyMemoryView_FromBuffer(&new_buffer);

    /* cast and pass buffer and shape */
    fib((double *) new_buffer.buf, size);

    return new_mview;
}

static PyObject *capi_pow(PyObject *self, PyObject *args)
{
    PyObject *obj;
    PyObject *mview;
    PyObject *out_mview;
    Py_buffer *buffer;
    Py_buffer *out_buffer;
    Py_ssize_t i, size;
    double * data;
    double * out_data;
    size = 1;

    /* Parse the input tuple */
    if (!PyArg_ParseTuple(args, "O", &obj))
        return NULL;
    if(PyLong_Check(obj)==1){
        return Py_BuildValue("d", pow(10.0, PyFloat_AsDouble(obj)));
    }else if(PyObject_CheckBuffer(obj)==1){
        mview = PyMemoryView_FromObject(obj);
        out_mview = mview_like(mview);
        
        buffer = PyMemoryView_GET_BUFFER(mview);
        out_buffer = PyMemoryView_GET_BUFFER(out_mview);

        data = (double *) buffer->buf;
        out_data = (double *) out_buffer->buf;

        for(i=0; i<buffer->ndim; i++){
            size *= buffer->shape[i];
        }
        for(i=0; i<size; i++){
            *(out_data+i) = pow(10.0, *(data+i));
        }
        return out_mview;
    }else{
        PyErr_SetString(PyExc_TypeError, "n must be a float or an int or an array-like.");
        return NULL;
    }
    
}

static PyMethodDef myMethods[] = {
    { "capi_fibonacci_array_input", (PyCFunction) capi_fibonacci_array_input, METH_VARARGS, fib_array_docstring },
    { "capi_fibonacci_new_array", (PyCFunction) capi_fibonacci_new_array, METH_VARARGS|METH_KEYWORDS, fib_mview_docstring },
    { "capi_pow", (PyCFunction) capi_pow, METH_VARARGS, NULL },
    { NULL, NULL, 0, NULL }
};

// Our Module Definition struct
static struct PyModuleDef capi_buffer_protocol = {
    PyModuleDef_HEAD_INIT,
    "capi_buffer_protocol",
    module_docstring,
    -1,
    myMethods
};

// Initializes our module using our above struct
PyMODINIT_FUNC PyInit_capi_buffer_protocol(void)
{
    return PyModule_Create(&capi_buffer_protocol);
}


