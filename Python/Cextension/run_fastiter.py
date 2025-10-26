from example import fastiter
import time 

N = 10

l = list(range(0, N))
t0 = time.time()
fastiter.iter(l)
t1 = time.time()
dt1 = (t1-t0) * 1e6
print("C ext")
print(dt1)
if N <=10:
    print(l)


g = list(range(0, N))
t0 = time.time()
for i in range(len(g)):
    g[i] *= g[i]
t1 = time.time()
dt2 = (t1-t0) * 1e6
print("Python")
print(dt2)
if N <=10:
    print(g)

print("")
print(dt1/dt2*100.0)


print(fastiter.PI)