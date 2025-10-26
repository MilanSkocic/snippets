from example import capi_callback
import numpy as np
print('\n')
print('**********************************************************************************')
print('Example callback function.')
print('***********************************************************************************')
p = np.asarray([10.0, 1.0])
x = np.linspace(1, 10, 3)
y = x+1
w = 1/y


def model(p, x):
    return p[0]*x+p[1]


def residuals(p, x, y, w, model):
    res = (y - model(p, x))*w
    return res

args = (x, y, w, model)
res = capi_callback.wrap_optimizer(residuals, p, args)
print(res)