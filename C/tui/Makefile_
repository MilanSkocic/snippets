CC=gcc
FC=gfortran
CFLAGS=-std=c11 -O3
FFLAGS=-std=f2018 -O3 -I$(HOME)/.local/include
LDFLAGS=-lncurses -lstdlib
C_SOURCES=$(wildcard *.c)
F_SOURCES=$(wildcard *.f90)
C_OBJECTS=$(patsubst %.c, %.o, $(C_SOURCES))
F_OBJECTS=$(patsubst %.f90, %.o, $(F_SOURCES))
EXE=app.out

all: $(EXE)

$(EXE): $(C_OBJECTS) $(F_OBJECTS)
	$(CC) $^ $(LDFLAGS) -o $@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) -c $(CFLAGS) $^ -o $@

$(F_OBJECTS): $(F_SOURCES)
	$(FC) -c $(FFLAGS) $^ -o $@

clean:
	rm -f *.o
	rm -f app*
