include conf.in

SRC_DIR=../src
BUILD_DIR=build
PROGRAM=../build/$(NAME)
MAN=$(BUILD_DIR)/$(NAME).$(SECTION)
HTML=$(BUILD_DIR)/$(NAME).$(SECTION).html

all: dirs $(MAN) $(HTML)

.PHONY: dirs 
dirs: 
	mkdir -p $(BUILD_DIR)

.PHONY: $(MAN)
$(MAN):
	help2man --no-info -I man.in $(PROGRAM) -o $(MAN)

$(HTML): $(MAN)
	man -Thtml $(MAN) > $(HTML) 

show: $(MAN)
	man $(MAN)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
