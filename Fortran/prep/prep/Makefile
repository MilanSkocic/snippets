include ../make.in

FFSRC=$(wildcard *.FF)
TEXSRC=$(wildcard *.tex)
MDSRC=$(wildcard *.md)


f90=$(patsubst %.FF, %.f90, $(FFSRC)) \
	$(patsubst %.tex, %.f90, $(TEXSRC)) \
	$(patsubst %.md, %.f90, $(MDSRC))

all: dirs sources
	mv -fv *.f90 ../$(SRCDIR)/

.PHONY: dirs
dirs:
	mkdir -p doc

sources: $(f90)

%.f90: %.FF
	prep $< -o $@

%.f90: %.tex
	prep $< -o $@

%.f90: %.md
	prep $< -o $@

clean:
	rm -f $(f90)
	rm -f doc/*
