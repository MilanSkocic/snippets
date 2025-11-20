CC=gcc
CFLAGS=-std=c11
LDFLAGS=-lm -lopenblas -lgsl
SOURCES=$(wildcard *.c)
OBJECTS=$(patsubst %.c, %.o, $(SOURCES))
EXE=test_gsl.out

all: $(EXE)

$(EXE): $(OBJECTS)
	gcc $^ $(LDFLAGS) -o $@

%.o: %.c
	gcc -c $^ -o $@