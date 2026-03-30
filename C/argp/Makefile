GCC=gcc
SRC=main.c
OBJ=main.o
EXE=testargp


all: $(OBJ)
	$(CC) -o $(EXE) $^

main.o: main.c
	$(CC) -c $< -o $@

.PHONY:
clean:
	rm $(OBJ) $(EXE)
