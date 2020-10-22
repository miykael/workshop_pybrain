say "Numpy Basics"

say "Import numpy module"
show "Import numpy module"
run "import numpy as np"

say "Why should you use Numpy?"
show "Why should you use Numpy?"
run "L = range(1000)
%timeit [i**2 for i in L]"
run "a = np.arange(1000)
%timeit a**2"

say "Linespace"
show "Linespace"
run "np.linspace(0, 1, 6)   # start, end, num-points"

say "Plotting of Python arrays"
show "Plotting of Python arrays"
run "import matplotlib.pyplot as plt"
run "x = np.linspace(0, 3, 20)
y = np.linspace(0, 9, 20)
x
y"
run "plt.plot(x, y)       # line plot
plt.plot(x, y, 'o')  # dot plot
plt.show()
"

say "Plotting of 2D data"
show "Plotting of 2D data"
run "image = np.random.rand(30, 30)
image"
run "plt.imshow(image, cmap=plt.cm.hot)
plt.colorbar()
plt.show()"

say "Indexing + Slicing"
show "Indexing + Slicing"
run "data = np.arange(10)
data"
run "data[:4]"
run "data[2:9:3]  # [start:end:step]"
run "data[::2]"
run "data[::-1]"
run "data[data%2==0]"

say "Fancy indexing"
show "Fancy indexing"
run "a = np.random.randint(0, 21, 15)
a"
run "a % 3 == 0"
run "a[a % 3 == 0] = -99
a"
run "a[a<=10] = 0
a"

say "Elementwise operations"
show "Elementwise operations"
run "data+10"
run "data**2"

say "Basic reductions"
show "Basic reductions"
run "data.sum(), data.mean(), data.std()"
run "a = np.random.randn(4,3)
a"
run "a[3, 1]"
run "a[-1, -2]"
run "a.shape"
run "a.mean()"
run "a.mean(axis=0)"
run "a.mean(axis=1)"
run "a.min()"
run "a.argmin()"
run "a.T # Transpose"
run "a.ravel()"
run "b = a.argsort()
b"
run "b.reshape(2, -1)"
