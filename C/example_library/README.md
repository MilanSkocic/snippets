Example of a C library 

Detailed description of the libary.

# Installation

See the file `INSTALL`.


# Dependencies

See the file `requirements`.


# License information

See the file `LICENSE` for information on the history of this
software, terms & conditions for usage, and a DISCLAIMER OF ALL
WARRANTIES.

# Use of README

The `README.md` file is written in __markdown__ but can be enhanced with html commands and/or doxygen commands usually used in for example `main.c` with `\\mainpage` command. In order to use a `README.md` file as mainpage, the doxyfile must be modified as following:

	l. 985: USE_MDFILE_AS_MAINPAGE = README.md

Be sure that the root path of the mainpage is added first in the `INPUT`:

	l. 793: INPUT                  = ./ ../../ ../../src/ ../../include/

