CC=gcc
FC=gfortran
CFLAGS=-std=c11 -O3
FFLAGS=-std=f2008
LDFLAGS=-lopenblas
C_SOURCES=$(wildcard *.c)
F_SOURCES=$(wildcard *.f90)
C_OBJECTS=$(patsubst %.c, %.o, $(C_SOURCES))
F_OBJECTS=$(patsubst %.f90, %.o, $(F_SOURCES))
EXE=array.out test_blas.out test_restrict.out

all: $(EXE)

array.out: $(C_OBJECTS)
	$(CC) array.o $(LDFLAGS) -o $@

test_blas.out: $(C_OBJECTS)
	$(CC) test_blas.o $(LDFLAGS) -o $@

test_restrict.out: $(C_OBJECTS)
	$(CC) test_restrict.o $(LDFLAGS) -o $@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) -c $(CFLAGS) $^

$(F_OBJECTS): $(F_SOURCES)
	$(FC) -c $(FFLAGS) $^

clean:
	rm -f *.o
	rm -f *.out