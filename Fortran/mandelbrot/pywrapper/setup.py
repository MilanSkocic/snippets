r"""Setup."""
import pathlib
import importlib
import platform
import site
from setuptools import setup, Extension

libraries = None
library_dirs = None
runtime_library_dirs = None
extra_objects = None

if platform.system() == "Linux":
    libraries = ["mandelbrot"]
    library_dirs = ["./pymandelbrot"]
    runtime_library_dirs = ["$ORIGIN"]
if platform.system() == "Windows":
    extra_objects = ["./pymandelbrot/libmandelbrot.dll.a"]
if platform.system() == "Darwin":
    libraries = ["mandelbrot"]
    library_dirs = ["./pymandelbrot"]
    runtime_library_dirs = ["@loader_path"]

if __name__ == "__main__":

    mod_ext = Extension(name="pymandelbrot.core",
                        sources=["./pymandelbrot/mandelbrot_core.c"],
                        libraries=libraries,
                        library_dirs=library_dirs,
                        runtime_library_dirs=runtime_library_dirs,
                        extra_objects=extra_objects)
    
    setup(ext_modules=[mod_ext])
    