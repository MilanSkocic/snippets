CC=gcc
CFLAGS = -O3 -DADD_
LDFLAGS =

all: gnuplot_gcc.out

gnuplot_gcc.out: gnuplot.o
	$(CC) -o $@ $^ $(LDFLAGS)

gnuplot.o: gnuplot.c
	$(CC) -o $@ -c $< $(CFLAGS)


.PHONY: run
run: all
	@echo "--> TESTING GNUPLOT <--"
	@./gnuplot_gcc

clean:
	rm *.o

cleanall: clean
	rm *.out
