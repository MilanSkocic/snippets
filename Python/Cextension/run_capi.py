from example import capi, capi_buffer_protocol, capi_callback
from example import cython_chi2
from example import ufuncs_example, ufuncs

import array
import numpy as np
import io

m=1
b=1
x = array.array('d',[1, 2, 3])
y = array.array('d',[1, 1, 1])
yerr = array.array('d', [1, 1, 1])
N = len(x)

print('************************************************************************************')
print('**** Example of computing chi2 - Demonstration of extentions with real numbers. ****')
print('************************************************************************************')

print("Chi2 written in C and wrap with Python/Numpy C API")
print(capi.capi_wrap_chi2(m, b, x, y, yerr))

print("\nChi2 written in C with Python/Numpy C API")
print(capi.capi_chi2(m, b, x, y, yerr))

print("\nChi2 written in C wrapped with Cython")
print(cython_chi2.cython_chi2(m, b, x, y, yerr, len(x)))

print("\nChi2 written with Cython")
print(cython_chi2.cython_wrap_chi2(m, b, x, y, yerr, len(x)))


print('\n')
print('*********************************************************************************************')
print('*****************************Example of custom ufunc*****************************************')
print('*********************************************************************************************')
print('Ufunc example')
print(ufuncs_example.absorbance(np.asarray(x), 1, 1, 1))

print('\n')
print('*********************************************************************************************')
print('Example of computing complex photocurrent - Demonstration of extentions with complex numbers.')
print('*********************************************************************************************')

t = """4.0e-05	1.0e+00	-5.0e+01	1.00e+00	1.70e+00	1.00e+00	2.00e+00	1.0000000e+00
6.0e-05	1.0e+00	1.30e+02	1.00e+00	2.40e+00	1.00e+00	2.00e+00	1.0000000e+00
5.0e-05	1.0e+00	1.40e+02	1.00e+00	2.80e+00	1.00e+00	2.00e+00	1.0000000e+00
9.0e-05	1.0e+00	-5.0e+01	1.00e+00	3.50e+00	1.00e+00	2.00e+00	1.0000000e+00"""

hv = hv = np.linspace(6, 2, 3)
prm = np.genfromtxt(io.StringIO(t))
K = prm[:,0].copy()
theta = prm[:, 2].copy()
Eg = prm[:, 4].copy()
phi_N = np.ones_like(hv)

print('\niph written in C and wrap with Python/Numpy C API')
print(capi.capi_wrap_iph(hv, K, theta, Eg, phi_N))


print("\niph written in C with Python/Numpy C API")
print(capi.capi_iph(hv, prm, phi_N))


print('\niph written with custom ufunc')
print(ufuncs.iph_with_ufunc(hv, prm, phi_N))


