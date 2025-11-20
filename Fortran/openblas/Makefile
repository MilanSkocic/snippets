CC=gcc
FC=gfortran
BUILD_DIR=build
SRC_DIR=src
LINKER=gfortran
CFLAGS=-std=c11
FFLAGS=-std=f2008 -J$(BUILD_DIR)
LDFLAGS=-lopenblas
C_SOURCES=$(wildcard $(SRC_DIR)/*.c)
F_SOURCES=$(wildcard $(SRC_DIR)/*.f90)
C_OBJECTS=$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SOURCES))
F_OBJECTS=$(patsubst $(SRC_DIR)/%.f90, $(BUILD_DIR)/%.o, $(F_SOURCES))
LIB=$(BUILD_DIR)/app

all: $(LIB)

$(LIB): $(C_OBJECTS) $(F_OBJECTS)
	$(LINKER) $^ $(LDFLAGS) -o $@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) -c $(CFLAGS) $^ -o $@

$(F_OBJECTS): $(F_SOURCES)
	$(FC) -c $(FFLAGS) $^ -o $@

clean:
	rm -rf $(BUILD_DIR)/*