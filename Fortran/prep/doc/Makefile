
TXT=$(wildcard *.txt)
MAN=$(patsubst %.3f.txt, %.3f, $(TXT))
HTML=$(patsubst %.3f.txt, %.3f.html, $(TXT))

all: $(MAN) $(HTML)
	@echo $(MAN)

%.3f: %.3f.txt
	txt2man $< > $@

%.3f.html: %.3f
	man2html $< > $@
