include make.in

VERSION=$(MS_VERSION)

all:

tex:
	$(MS_TEX) -synctex=1 -output-dir=$(MS_BUILD_DIR) $(MS_SRC_DIR)/main.tex

info:
	$(MS_MAKEINFO) -D "VERSION $(VERSION)" $(MS_SRC_DIR)/main.texi -o $(MS_BUILD_DIR)/main.info

infopdf:
	$(MS_MAKEINFO) -D "VERSION $(VERSION)" --pdf $(MS_SRC_DIR)/main.texi -o $(MS_BUILD_DIR)/main.info.pdf

clean:
	rm -rf $(MS_BUILD_DIR)/*
