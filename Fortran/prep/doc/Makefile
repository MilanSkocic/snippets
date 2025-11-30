PREPDIR=prep

PREP=$(wildcard $(PREPDIR)/*.prepdoc)
MAN=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f, $(PREP))
MANGZ=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f.gz, $(PREP))
MANPDF=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f.pdf, $(PREP))
MANLATEX=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f.tex, $(PREP))
MANHTML=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f.html, $(PREP))
MANTXT=$(patsubst $(PREPDIR)/%.3f.prepdoc, man/%.3f.txt, $(PREP))

DOC_TXT=txt/manual.txt
DOC_LATEX=latex/manual.tex

all: man txt latex



#------------------------------------------------------------------------------
# MAN OUTPUT
man: $(MAN) mangz mantxt manhtml manpdf manlatex

mangz: $(MANGZ)

mantxt: $(MANTXT)

manhtml: $(MANHTML)

manlatex: $(MANLATEX)

manpdf: $(MANPDF)

man/%.3f: prep/%.3f.prepdoc
	txt2man -s 3f -t $(shell basename -s .prepdoc $<) -r "codata" -v "Library Functions Manual"  $< > $@

man/%.3f.gz: man/%.3f
	gzip -c $< > $@

man/%.3f.pdf: man/%.3f
	pandoc -s --from man --to pdf $< -o $@

man/%.3f.tex: man/%.3f
	pandoc --from man --to latex $< -o $@
	echo "" >> $@
	echo "" >> $@
	echo "" >> $@

man/%.3f.html: man/%.3f
	man2html -r $< > $@

man/%.3f.txt: man/%.3f
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
latex: $(DOC_LATEX)

$(DOC_LATEX): $(MANLATEX)
	cat $^ > $@
#------------------------------------------------------------------------------




#------------------------------------------------------------------------------
# OTHERS
clean:
	rm -f $(PREP) $(MAN) $(MANGZ) $(MANTXT) $(MANHTML) $(MANLATEX) $(MANPDF) $(DOC_TXT) $(DOC_LATEX)
