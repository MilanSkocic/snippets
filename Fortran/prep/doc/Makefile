
TXT=$(wildcard *.txt)
MAN=$(patsubst %.3f.txt, %.3f, $(TXT))
HTML=$(patsubst %.3f.txt, %.3f.html, $(TXT))

all: $(MAN) $(HTML)
	@echo $(MAN)

%.3f: %.3f.txt
	txt2man -s 3f -t $< -r "codata" -v "Library Functions Manual"  $< > $@

%.3f.html: %.3f
	man2html $< > $@
	pandoc --from man --to html $< -o $@

clean:
	rm $(MAN) $(HTML)
