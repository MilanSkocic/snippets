CC=gcc
FC=gfortran
LINKER=gfortran
CFLAGS=-std=c11
BUILD_DIR=build
FFLAGS=-std=f2008 -J$(BUILD_DIR)
LDFLAGS=
C_SOURCES=$(wildcard *.c)
F_SOURCES=$(wildcard *.f90)
C_OBJECTS=$(patsubst %.c, %.o, $(C_SOURCES))
F_OBJECTS=$(patsubst %.f90, %.o, $(F_SOURCES))
EXE=app

all: $(EXE)

$(EXE): $(C_OBJECTS) $(F_OBJECTS)
	$(LINKER) $(BUILD_DIR)/$^ $(LDFLAGS) -o $(BUILD_DIR)/$@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) -c $(CFLAGS) $^ -o $(BUILD_DIR)/$@

$(F_OBJECTS): $(F_SOURCES)
	$(FC) -c $(FFLAGS) $^ -o $(BUILD_DIR)/$@

clean:
	rm -rf $(BUILD_DIR)/*