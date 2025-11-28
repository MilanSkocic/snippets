FFSRC=$(wildcard *.FF)
TEXSRC=$(wildcard *.tex)
MDSRC=$(wildcard *.md)

SRC=$(patsubst %.FF, %.f90, $(FFSRC)) $(patsubst %.tex, %.f90, $(TEXSRC)) $(patsubst %.md, %.f90, $(MDSRC))

export PREP_DOCUMENT_DIR=./

all: $(SRC)

%.f90: %.FF
	prep --comment doxygen $<

%.f90: %.tex
	prep -i $<

%.f90: %.md
	prep -i $< -o $@

.PHONY: doc
doc:
	make -C doc
	doxygen doxin

tex:


clean:
	rm -rf *.f90
