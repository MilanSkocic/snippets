from example import capi_buffer_protocol
import numpy as np
import array

print('\n')
print('**********************************************************************************')
print('Example of creating memoryview - Demonstration of extentions with buffer protocol.')
print('***********************************************************************************')
a = array.array('d', (1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
print('\nInitial array from the array module')
print(a, "id=", id(a))

out = capi_buffer_protocol.capi_fibonacci_array_input(a)
print('\nInitial array with the Fibonacci serie computed at C level working directly on the underlying buffer.')
print(out, "id=", id(out))

out = capi_buffer_protocol.capi_fibonacci_new_array(10)

print('\nNew memory view created at C level - can be used by Numpy')
print(out, id(out))

print('\tnbytes', out.nbytes)
print('\tndim', out.ndim)
print('\tshape', out.ndim)
print('\titemsize', out.itemsize)
print('\tobj', out.obj)
print('\tformat', out.format)
print('\tc_contiguous', out.c_contiguous)
print('\tf_contiguous', out.f_contiguous)
print('\tstrides', out.strides)
print('\treadonly', out.readonly)

print('\n\tExample of exporting to list')
print(out.tolist())
nparr = np.asarray(out, order="C")
print(nparr, id(nparr))
print(nparr.flags, nparr.strides)


a = np.linspace(0, 3, 10)
b = np.linspace(2, 6, 10)
c = np.vstack((a,b))
res = capi_buffer_protocol.capi_pow(c)
print(res, id(res))
print(np.asarray(res))