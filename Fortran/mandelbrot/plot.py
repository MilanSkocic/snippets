import numpy as np
import matplotlib.pyplot as plt

m = np.loadtxt("./mb.txt")
x = np.loadtxt("./xx.txt")
y = np.loadtxt("./yy.txt")

plt.figure()
plt.contourf(x,y,m)
plt.gca().set_aspect("equal")
plt.savefig("./mb.png", dpi=300, format="png")

m = np.loadtxt("./jl.txt")
x = np.loadtxt("./xx.txt")
y = np.loadtxt("./yy.txt")
plt.figure()
plt.contourf(x,y,m)
plt.gca().set_aspect("equal")
plt.savefig("./jl.png", dpi=300, format="png")

plt.show()