# Description

Here is an example how to create a GUI with Tk in a C program.

For windows, the following dlls must be placed in the same folder as the executable:

* tcl86.dll
* tk86.dll
* zlib.dll

Those dlls are found in the msys installation folder, usually in C:\msys64\mingw64\bin.

Additionally, two folders must be placed in lib folder containing all the necessary for tk to run
properly:

* lib/tcl8.6 found in C:\msys64\mingw64\lib
* lib/tk8.6 found in C:\msys64\mingw64\lib