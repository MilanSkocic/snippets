SRC_DIR=src
BUILD_DIR=build

SRC=$(wildcard $(SRC_DIR)/*.md)
GZ=$(patsubst $(SRC_DIR)/%.md, $(BUILD_DIR)/%, $(SRC))
HTML=$(patsubst $(BUILD_DIR)/%, $(BUILD_DIR)/%.html, $(GZ))

.PHONY: clean

all: $(GZ) $(HTML)

$(BUILD_DIR)/%: $(SRC_DIR)/%.md
	pandoc --standalone --to man --from markdown $^ -o $@

$(BUILD_DIR)/%.html: $(BUILD_DIR)/%
	pandoc --standalone --to html --from man $^ -o $@

show: $(GZ)
	man $(BUILD_DIR)/test*.1

clean:
	rm -rf $(BUILD_DIR)/*
