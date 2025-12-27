GCC=gcc
SRC=main.c
OBJ=main.o


all: $(OBJ)
	$(CC) -o parse $^

main.o: main.c
	$(CC) -c -Wall -pedantic $< -o $@
