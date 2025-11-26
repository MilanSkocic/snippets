FFSRC=$(wildcard *.FF)
SRC=$(patsubst %.FF, %.f90, $(FFSRC))

export PREP_DOCUMENT_DIR=./

all: $(SRC) 

%.f90: %.FF
	prep --comment doxygen $< -o $@

.PHONY: doc
doc:
	make -C doc
	doxygen doxin

clean:
	rm -rf *.f90
