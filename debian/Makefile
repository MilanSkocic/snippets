include make.in


SRC=$(MYDEBIAN_SRC_DIR)/$(MYDEBIAN_NAME).sh
BIN=$(MYDEBIAN_BUILD_DIR)/$(MYDEBIAN_NAME)
MAN=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME)
MANGZ=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME).gz
HTML=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME).html
PDF=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME).pdf

prefix ?= $(HOME)/.local

.PHONY: clean doc

all: $(BIN)

$(BIN): $(SRC)
	mkdir -p build
	cp $< $@
	chmod +x $@

doc: $(BIN) 
	$(BIN) --help > README
	txt2man -s 1 -t $(MYDEBIAN_NAME) -v "User commands" -r $(MYDEBIAN_VERSION) README > $(MAN)
	man -Thtml -l $(MAN) > $(HTML) 
	gzip -f $(MAN)

docs: doc
	rm -fv docs/$(HTML)
	mv -fv $(HTML) docs/index.html

show_man: doc
	man $(MANGZ)
	
test: $(BIN)
	$(BIN) --version
	$(BIN) --help

install: $(BIN)
	mkdir -p $(DESTDIR)$(prefix)/bin
	mkdir -p $(DESTDIR)$(prefix)/share/man/man$(MYDEBIAN_MAN_SEC)
	cp $(BIN) $(DESTDIR)$(prefix)/bin/
	cp $(MANGZ) $(DESTDIR)$(prefix)/share/man/man$(MYDEBIAN_MAN_SEC)/

uninstall: $(BIN)
	rm $(DESTDIR)$(prefix)/bin/$(MYDEBIAN_NAME)
	rm $(DESTDIR)$(prefix)/share/man/man$(MYDEBIAN_MAN_SEC)/$(MYDEBIAN_NAME)*

clean:
	rm -rf $(MYDEBIAN_BUILD_DIR)/*
