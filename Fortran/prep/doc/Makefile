include ../make.in

PREPDOCDIR=../$(PREPDIR)/doc

PREP=$(wildcard $(PREPDOCDIR)/*.prepdoc)
MAN=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f, $(PREP))
MANGZ=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.gz, $(PREP))
MANPDF=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.pdf, $(PREP))
MANLATEX=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.tex, $(PREP))
MANHTML=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.html, $(PREP))
MANTXT=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.txt, $(PREP))

DOC_TXT=build/txt/$(NAME).txt
DOC_LATEX=build/latex/$(NAME).tex
DOC_LATEX_PDF=build/latex/$(NAME).pdf

all: dirs man txt latex

.PHONY: dirs
dirs:
	mkdir -p build/html build/latex build/man build/txt

#------------------------------------------------------------------------------
# MAN OUTPUT
man: $(MAN) mangz mantxt manhtml manpdf manlatex

mangz: $(MANGZ)

mantxt: $(MANTXT)

manhtml: $(MANHTML)

manlatex: $(MANLATEX)

manpdf: $(MANPDF)

build/man/%.3f: $(PREPDOCDIR)/%.3f.prepdoc
	txt2man -s 3f -t $(shell basename -s .prepdoc $<) -r $(NAME) -v "Library Functions Manual"  $< > $@

build/man/%.3f.gz: build/man/%.3f
	gzip -c $< > $@

build/man/%.3f.pdf: build/man/%.3f
	pandoc -s --from man --to pdf $< -o $@

build/man/%.3f.tex: build/man/%.3f
	pandoc --from man --to latex $< -o $@
	echo "" >> $@
	echo "" >> $@
	echo "" >> $@

build/man/%.3f.html: build/man/%.3f
	man2html -r $< > $@

build/man/%.3f.txt: build/man/%.3f
	man $< > $@
	echo "" >> $@
	echo "" >> $@
	echo "" >> $@
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# TXT OUTPUT
txt: $(DOC_TXT)

$(DOC_TXT): $(MANTXT)
	cat $^ > $@
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# LATEX OUTPUT
latex: $(DOC_LATEX) $(DOC_LATEX_PDF)

$(DOC_LATEX): $(MANLATEX)
	./make_latexpdf $^

$(DOC_LATEX_PDF): $(DOC_LATEX)
	pdflatex --synctex=1 --output-dir=build/latex $< -o $@
	pdflatex --synctex=1 --output-dir=build/latex $< -o $@
	pdflatex --synctex=1 --output-dir=build/latex $< -o $@

#------------------------------------------------------------------------------




#------------------------------------------------------------------------------
# OTHERS
clean:
	rm -rf build/*
