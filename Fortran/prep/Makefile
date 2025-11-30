include make.in


all: dirs prep

.PHONY: dirs
dirs:
	mkdir -p build

.PHONY: prep
prep:
	make -C prep

.PHONY: doc
doc:
	make -C doc

clean:
	rm -rf $(BUILDDIR)/*
	make -C prep clean
	make -C doc clean
