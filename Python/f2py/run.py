from example import fib_c, fib_f90
import time


print("Run Fibonacci written in C")

t0 = time.time()
result = fib_c.fib(10)
t1 = time.time()

print(result)
print("Execution time: {0:.2f} us".format((t1-t0)*1e6))


print("Run Fibonacci written in Fortran90")

t0 = time.time()
result = fib_f90.fibf90(10)
t1 = time.time()

print(result)
print("Execution time: {0:.2f} us".format((t1-t0)*1e6))







