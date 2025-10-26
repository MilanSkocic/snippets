from setuptools import setup, find_packages, Extension
import configparser
from Cython.Build import cythonize
import numpy

cfg = configparser.ConfigParser()
cfg.read("site.cfg")

openblas_include = cfg["OPENBLAS"]["include_dirs"]
openblas_link = "-l"+cfg["OPENBLAS"]["libraries"]

# import Cython.Compiler.Options
# Cython.Compiler.Options.annotate = True

cython_ext = Extension(name="example.cython_chi2",
                       sources=["./example/cython_chi2.pyx", "./example/chi2.c"],
                       include_dirs=[numpy.get_include()],
                       define_macros=[('NPY_NO_DEPRECATED_API', 'NPY_1_7_API_VERSION')])

capi_example = Extension(name="example.capi",
                         sources=["./example/capi.c",
                                  "./example/chi2.c",
                                  "./example/iph.c"],
                         include_dirs=[numpy.get_include()],
                         define_macros=[('NPY_NO_DEPRECATED_API', 'NPY_1_7_API_VERSION')])

capi_buffer_protocol_example = Extension(name="example.capi_buffer_protocol",
                                         sources=["./example/capi_buffer_protocol.c",
                                                  "./example/fib.c"],
                                          include_dirs=[openblas_include],
                                          extra_link_args=[openblas_link])

fastiter = Extension(name="example.fastiter", sources=["./example/fastiter.c"])
                      
capi_callback_example = Extension(name="example.capi_callback",
                         sources=["./example/capi_callback_function.c",
                                  "./example/optimizer.c"],
                         include_dirs=[numpy.get_include()],
                         define_macros=[('NPY_NO_DEPRECATED_API', 'NPY_1_7_API_VERSION')])

numpy_ufuncs_ext = Extension("example.ufuncs_example",
                             ["./example/ufunc_example.c"],
                             include_dirs=[numpy.get_include(), "./example"])

setup(
    name="C Extension Demo",
    version="1.0",
    packages=find_packages(),
    include_package_data=True,
    ext_modules=[capi_example, fastiter,
                 numpy_ufuncs_ext, capi_buffer_protocol_example, capi_callback_example] + cythonize(cython_ext, annotate=True)
)


# pypi
# >>> python setup.py sdist bdist_wheel
# >>> python -m twine upload dist/*
# >>> python -m twine upload --repository testpypi dist/*

# anaconda in recipe folder
# >>> conda config --set anaconda_upload no
# >>> conda build .
# >>> conda build . --output
# >>> anaconda login
# >>> anaconda upload /path/to/conda-package.tar.bz2

# anaconda with pypi folders
# >>> anaconda upload dist/*.tar.gz
# >>> pip install --extra-index-url https://pypi.anaconda.org/USERNAME/PACKAGE
