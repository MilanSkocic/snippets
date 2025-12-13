include make.in

VERSION=$(MS_VERSION)
CLEANUP=cleantexi.sh
MAKEINFO_OPTIONS=-D "VERSION $(VERSION)" -D "TITLE $(MS_NAME)" -D "AUTHOR $(MS_AUTHOR)"
MK4BUILD=html.mk4
MK4CFG=html.cfg
NCL=makeindex

all:

pdf: 
	$(MS_TEX) -synctex=1 -output-dir=$(MS_BUILD_DIR) $(MS_SRC_DIR)/main.tex
	#$(NCL) ./$(MS_BUILD_DIR)/main.nlo -s nomencl.ist -o ./$(MS_BUILD_DIR)/main.nls

index:
	$(NCL) ./$(MS_BUILD_DIR)/cp.idx
	$(NCL) ./$(MS_BUILD_DIR)/fn.idx

info:
	$(MS_MAKEINFO) $(MAKEINFO_OPTIONS)  $(MS_SRC_DIR)/main.texi -o $(MS_BUILD_DIR)/main.info

latex:
	$(MS_MAKEINFO) $(MAKEINFO_OPTIONS) --latex $(MS_SRC_DIR)/main.texi -o $(MS_SRC_DIR)/main.tex

html:
	make4ht -c $(MK4CFG) -e $(MK4BUILD) -B $(MS_BUILD_DIR) -d $(MS_BUILD_DIR) $(MS_SRC_DIR)/main.tex

clean:
	rm -rf $(MS_BUILD_DIR)/*
