include make.in

SRCDIR=src

FFSRC=$(wildcard $(SRCDIR)/*.FF)
TEXSRC=$(wildcard $(SRCDIR)/*.tex)
MDSRC=$(wildcard $(SRCDIR)/*.md)

SRC=$(patsubst $(SRCDIR)/%.FF, $(SRCDIR)/%.f90, $(FFSRC)) $(patsubst $(SRCDIR)/%.tex, $(SRCDIR)/%.f90, $(TEXSRC)) $(patsubst $(SRCDIR)/%.md, $(SRCDIR)/%.f90, $(MDSRC))

export PREP_DOCUMENT_DIR=./

all: $(SRC)

$(SRCDIR)/%.f90: $(SRCDIR)/%.FF
	prep $< -o $@

$(SRCDIR)/%.f90: $(SRCDIR)/%.tex
	prep $< -o $@

$(SRCDIR)/%.f90: $(SRCDIR)/%.md
	prep $< -o $@

.PHONY: doc
doc:
	make -C doc

clean:
	rm $(SRC)
