include ../make.in

PREPDOCDIR=../$(PREPDIR)/doc

PREP=$(wildcard $(PREPDOCDIR)/*.prepdoc)
MAN=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f, $(PREP))
MANGZ=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.gz, $(PREP))
MANPDF=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.pdf, $(PREP))
MANLATEX=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.tex, $(PREP))
MANHTML=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.html, $(PREP))
MANTXT=$(patsubst $(PREPDOCDIR)/%.3f.prepdoc, build/man/%.3f.txt, $(PREP))

DOC_TXT=build/txt/$(NAME)-documentation.txt
DOC_PREP=build/txt/$(NAME)-documentation.prepdoc
DOC_LATEX=build/latex/$(NAME)-documentation.tex
DOC_LATEX_PDF=build/latex/$(NAME)-documentation.pdf

all: dirs man txt latex

.PHONY: dirs
dirs:
	mkdir -p build/html build/latex build/man build/txt
	mkdir -p html pdf txt

#------------------------------------------------------------------------------
# MAN OUTPUT
man: $(MAN) mangz mantxt manhtml manlatex

mangz: $(MANGZ)

mantxt: $(MANTXT)

manhtml: $(MANHTML)

manlatex: $(MANLATEX)

manpdf: $(MANPDF)

# PREPDOC -> MAN
build/man/%.3f: $(PREPDOCDIR)/%.3f.prepdoc
	txt2man -s 3f -t $(shell basename -s .prepdoc $<) -r $(NAME) -v "Library Functions Manual"  $< > $@

# MAN -> MAN GZ
build/man/%.3f.gz: build/man/%.3f
	gzip -c $< > $@

# MAN -> TXT
build/man/%.3f.txt: build/man/%.3f
	man $< > $@

# MAN -> HTML
build/man/%.3f.html: build/man/%.3f
	man2html -r $< > $@

# MAN -> LATEX
build/man/%.3f.tex: build/man/%.3f
	./man2latex.sh $^ $@

# MAN -> PDF 
build/man/%.3f.pdf: build/man/%.3f
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# TXT OUTPUT
txt: $(DOC_TXT)

$(DOC_TXT): $(MANTXT)
	./txtdoc.sh $^
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# LATEX OUTPUT
latex: $(DOC_LATEX) $(DOC_LATEX_PDF)

$(DOC_LATEX): $(MANLATEX)
	./make_latexpdf

$(DOC_LATEX_PDF): $(DOC_LATEX)
	pdflatex -synctex=1 -output-directory=build/latex $<
	pdflatex -synctex=1 -output-directory=build/latex $<
	pdflatex -synctex=1 -output-directory=build/latex $<
	make4ht -d build/html -B build/html $< 

#------------------------------------------------------------------------------




#------------------------------------------------------------------------------
# OTHERS
clean:
	rm -rf build/*
