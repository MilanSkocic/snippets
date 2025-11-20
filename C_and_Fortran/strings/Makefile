CC=gcc
FC=gfortran
LINKER=gfortran
CFLAGS=-std=c11
FFLAGS=-std=f2008
LDFLAGS=-lopenblas
C_SOURCES=$(wildcard *.c)
F_SOURCES=$(wildcard *.f90)
C_OBJECTS=$(patsubst %.c, %.o, $(C_SOURCES))
F_OBJECTS=$(patsubst %.f90, %.o, $(F_SOURCES))
EXE=capp fapp

all: $(EXE)

capp: cmain.o c_func.o precisions.o f_func.o
	$(LINKER) $^ $(LDFLAGS) -o $@

fapp: precisions.o f_func.o c_func.o fmain.o
	$(LINKER) $^ $(LDFLAGS) -o $@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) -c $(CFLAGS) $^

$(F_OBJECTS): $(F_SOURCES)
	$(FC) -c $(FFLAGS) $^

clean:
	rm -f *.o
	rm -f gui.*