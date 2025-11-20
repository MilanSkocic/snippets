include make.in


SRC=$(MYDEBIAN_SRC_DIR)/$(MYDEBIAN_NAME).sh
BIN=$(MYDEBIAN_BUILD_DIR)/$(MYDEBIAN_NAME)
MAN=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME)
HTML=$(MYDEBIAN_MAN_DIR)/$(MYDEBIAN_MAN_NAME).html

DESTDIR=$(HOME)
PREFIX=.local

.PHONY: clean doc

all: $(BIN)

$(BIN): $(SRC)
	cp $< $@
	chmod +x $@

doc: $(BIN) 
	make -C doc

test: $(BIN)
	$(BIN) --version
	$(BIN) --help

install: $(BIN)
	cp $(BIN) $(DESTDIR)/$(PREFIX)/bin/
	cp $(GZ) $(DESTDIR)/$(PREFIX)/share/man/man$(MYDEBIAN_MAN_SEC)/

uninstall: $(BIN)
	rm $(DESTDIR)/$(PREFIX)/bin/$(MYDEBIAN_NAME)
	rm $(DESTDIR)/$(PREFIX)/share/man/man$(MYDEBIAN_MAN_SEC)/$(MYDEBIAN_NAME)*

clean:
	rm -rf $(MYDEBIAN_BUILD_DIR)/*
