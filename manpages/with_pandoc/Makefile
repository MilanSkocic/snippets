SRC_DIR=./src
MAN_DIR=./man

SRC=$(wildcard $(SRC_DIR)/*.md)
GZ=$(patsubst $(SRC_DIR)/%.md, $(MAN_DIR)/%.gz, $(SRC))
HTML=$(patsubst $(MAN_DIR)/%.gz, $(MAN_DIR)/%.html, $(GZ))

.PHONY: clean

all: $(GZ) $(HTML)

$(MAN_DIR)/%.gz: $(SRC_DIR)/%.md
	pandoc --standalone --to man --from markdown $^ -o $@

$(MAN_DIR)/%.html: $(MAN_DIR)/%.gz
	pandoc --standalone --to html --from man $^ -o $@
	for i in 1 2 3 4 5 6 7 8; do \
		mv man/*.$$i.* man/man$$i/ 2>/dev/null; true; \
	done
	

clean:
	rm -rf man/*
