include make.in


FFSRC=$(wildcard $(SRCDIR)/prep/*.FF)
TEXSRC=$(wildcard $(SRCDIR)/prep/*.tex)
MDSRC=$(wildcard $(SRCDIR)/prep/*.md)

SRC=$(patsubst $(SRCDIR)/prep/%.FF, $(SRCDIR)/%.f90, $(FFSRC)) \
	$(patsubst $(SRCDIR)/prep/%.tex, $(SRCDIR)/%.f90, $(TEXSRC)) \
	$(patsubst $(SRCDIR)/prep/%.md, $(SRCDIR)/%.f90, $(MDSRC))


all: sources prep

sources: $(SRC)

$(SRCDIR)/%.f90: $(SRCDIR)/prep/%.FF
	prep $< -o $@

$(SRCDIR)/%.f90: $(SRCDIR)/prep/%.tex
	prep $< -o $@

$(SRCDIR)/%.f90: $(SRCDIR)/prep/%.md
	prep $< -o $@

prep: $(SRC)
	mv -fv doc/*.prepdoc doc/prep/

.PHONY: doc
doc:
	make -C doc

clean:
	rm -rf $(BUILDDIR)/doc/*
	rm -f $(SRC)
