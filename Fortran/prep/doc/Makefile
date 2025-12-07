include ../make.in

DOC_BUILD_DIR=$(CODE_BUILDDIR)

.ONESHELL:

.PHONY: all dirs tex biber bibtex index link copy clean html

all: dirs tex biber index link copy

dirs:
	mkdir -p $(DOC_BUILD_DIR)
	mkdir -p $(DOC_BIN_DIR)

tex:
	$(DOC_TEX) -output-directory=./$(DOC_BUILD_DIR) -synctex=1 $(DOC_SRC_DIR)/$(DOC_FNAME).tex
	
biber:
	$(DOC_BIB) ./$(DOC_BUILD_DIR)/$(DOC_FNAME).bcf --output-file ./$(DOC_BUILD_DIR)/$(DOC_FNAME).bbl

bibtex:
	cp $(DOC_SRC_DIR)/references.bib $(DOC_BUILD_DIR)/
	cd $(DOC_BUILD_DIR)
	$(DOC_BIB) $(DOC_FNAME).aux 
	cd ..

link:
	$(DOC_TEX) -output-directory=./$(DOC_BUILD_DIR) -synctex=1 $(DOC_SRC_DIR)/$(DOC_FNAME).tex
	$(DOC_TEX) -output-directory=./$(DOC_BUILD_DIR) -synctex=1 $(DOC_SRC_DIR)/$(DOC_FNAME).tex

index: 
	$(DOC_NCL) ./$(DOC_BUILD_DIR)/$(DOC_FNAME).nlo -s nomencl.ist -o ./$(DOC_BUILD_DIR)/$(DOC_FNAME).nls
	$(DOC_NCL) ./$(DOC_BUILD_DIR)/$(DOC_FNAME).idx

copy: 
	cp -rf $(DOC_BUILD_DIR)/$(DOC_FNAME).pdf $(DOC_BIN_DIR)/$(DOC_OUTNAME).pdf
	cp ./$(DOC_BUILD_DIR)/$(DOC_FNAME).idx ./$(DOC_BUILD_DIR)/$(DOC_FNAME).4idx

html: 
	make4ht -c $(DOC_MK4CFG) -d $(DOC_HTML_DIR) -B $(DOC_BUILD_DIR) -e $(DOC_MK4BUILD) $(DOC_SRC_DIR)/$(DOC_FNAME).tex -a info

clean:
	rm -rf $(DOC_BUILD_DIR)/*
	rm -rf $(DOC_BIN_DIR)/*
	rm -rf $(DOC_HTML_DIR)/*

