CC=gcc
FC=gfortran
LINKER=gfortran
CFLAGS=-std=c11 -I./ -Wall -Wextra -pedantic
FFLAGS=-std=f2008 -Wall -Wextra -pedantic
LDFLAGS=
C_SOURCES=$(wildcard *.c)
F_SOURCES=$(wildcard *.f90)
C_OBJECTS=$(patsubst %.c, %.o, $(C_SOURCES))
F_OBJECTS=$(patsubst %.f90, %.o, $(F_SOURCES))
EXE=capp fapp

all: $(EXE)

capp: fobject_simple.o fobject_cmpl.o cmain.o
	$(LINKER) $^ $(LDFLAGS) -o $@

fapp: fobject_simple.o fobject_cmpl.o fmain.o
	$(LINKER) $^ $(LDFLAGS) -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $^

%.o: %.f90
	$(FC) -c $(FFLAGS) $^

clean:
	rm -f *.o
	rm -f *.mod
	rm -f fapp*
	rm -f capp*