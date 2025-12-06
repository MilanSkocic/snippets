#!/usr/bin/env bash

source make.in

ROOT=doc
BUILD_DIR=$ROOT/build
FORMATS="man txt latex html"
TEMPLATE_DIR=$ROOT
LATEXPKGS=$TEMPLATE_DIR/packages.tex
TEXENGINE=pdflatex

FLAGS_RM="-rf"
FLAGS_MV="-f"

OPTION_CLEAN=0
OPTION_VERBOSE=0
OPTION_LATEX_VERBOSE="--interaction=batchmode"
OPTION_MK4_LOGLEVEL=fatal

args=($*)
for arg in $args; do
    case $arg in
        "--clean")
            OPTION_CLEAN=1
            ;;
        "--verbose")
            OPTION_VERBOSE=1
            FLAGS_RM="-rfv"
            FLAGS_MV="-fv"
            ;;
        "--verbose_latex")
            OPTION_LATEX_VERBOSE=""
            ;;
        "--debug_make4ht")
            OPTION_MK4_LOGLEVEL=debug
            ;;
        *)
            ;;
    esac
done

if [[ $OPTION_CLEAN == 1 ]]; then
    echo "[INFO]: Cleaning."
    rm $FLAGS_RM "$BUILD_DIR/"
    echo "[STATUS]: Cleaning done."
    exit 0;
fi


echo "[INFO]: Generating folders."
for format in $FORMATS; do
    mkdir -p $BUILD_DIR/$format
done
echo "[STATUS]: Folders created."


echo "[INFO]: Generating man pages."
files=$(ls prep/doc/*.prepdoc)
for file in $files; do
    man_name=$(basename -s .prepdoc $file)
    man_section=$(echo $man_name | cut -d "." -f 2)
    man_number=${man_section:0:1}
    
    fp_man=$( echo $file | sed "s/.prepdoc//g")
    fp_man=$( echo $fp_man | sed "s:prep/doc:$BUILD_DIR/man:g")
    fp_mantxt="$fp_man.txt"
    fp_manhtml="$fp_man.html"
    fp_mantex="$fp_man.tex"
    fp_mantexpdf="$fp_man-pdf.tex"
    fp_manpdf="$fp_man.pdf"
   
    # man
    if [[ $VERBOSE == 1 ]]; then echo "   $file -> $fp_man"; fi
	txt2man -s $man_section -t $man_name -r $NAME -v "Library Functions Manual"  $file > $fp_man
    
    # txt
    if [[ $VERBOSE == 1 ]]; then echo "   $fp_man -> $fp_mantxt"; fi
    man $fp_man > $fp_mantxt
    
    # html 
    if [[ $VERBOSE == 1 ]]; then echo "   $fp_man -> $fp_manhtml"; fi
    man2html -r $fp_man > $fp_manhtml
    
    # tex
    if [[ $VERBOSE == 1 ]]; then echo "   $fp_man -> $fp_mantex";fi
    echo "" > $fp_mantex
    echo "\\begin{Verbatim}[frame=lines,label=$man_name]" >> $fp_mantex
    man -l $fp_man >> $fp_mantex
    echo "\\end{Verbatim}" >> $fp_mantex
    echo "" >> $fp_mantex
    echo "" >> $fp_mantex
    echo "" >> $fp_mantex
    
    # pdf
    if [[ $VERBOSE == 1 ]]; then  echo "   $fp_man -> $fp_mantexpdf";fi
    title="$NAME $VERSION --- $man_name"
    
    echo "\\documentclass[11pt, a4paper]{article}" > $fp_mantexpdf
    cat $LATEXPKGS >> $fp_mantexpdf

    echo  "\\title{$title}" >> $fp_mantexpdf
    echo "\\author{$AUTHOR}" >> $fp_mantexpdf
    
    echo "\\begin{document}" >> $fp_mantexpdf
    echo "\\maketitle" >> $fp_mantexpdf
    echo "\\input{$fp_mantex}" >> $fp_mantexpdf
    echo "\\end{document}" >> $fp_mantexpdf
    
    tmp_dir="$BUILD_DIR/man/build_$man_name"
    mkdir -p $tmp_dir
    $TEXENGINE -synctex=1 -output-directory=$tmp_dir $OPTION_LATEX_VERBOSE $fp_mantexpdf
    mv $FLAGS_MV $tmp_dir/"$man_name-pdf.pdf" $fp_manpdf
    rm $FLAGS_RM $tmp_dir
    rm $FLAGS_RM $fp_mantexpdf
done
echo "[STATUS]: Man pages created."



echo "[INOF]: Generating text documentation."
DOC="$BUILD_DIR/txt/$NAME-doc.txt"
files=$(ls $BUILD_DIR/man/*.txt)
    echo "                     $NAME - DOCUMENTATION - $VERSION                   " > $DOC
    echo "" >> $DOC

    for i in $files; do

    echo "------------------------------------------------------------------------" >> $DOC
    cat $i >> $DOC
    echo "------------------------------------------------------------------------" >> $DOC
    echo "" >> $DOC
    echo "" >> $DOC
done
echo "[STATUS]: Text documentation created."


echo "[INOF]: Generating latex documentation."
DOC="$BUILD_DIR/latex/prep.tex"
files=$(ls $BUILD_DIR/man/*.tex)
echo "" > $DOC
for file in $files; do
    man_name=$(basename -s .tex $file)
    man_section=$(echo $man_name | cut -d "." -f 2)
    man_number=${man_section:0:1}
    echo "\\section{$man_name\\index{$man_name}}\\label{sec_$man_name}" >> $DOC
    # echo "\\input{$file}" >> $DOC
    echo "\\input{build/man/$(basename $file)}" >> $DOC
    echo "" >> $DOC
done

#$TEXENGINE -synctex=1 -output-directory=$tmp_dir $OPTION_LATEX_VERBOSE $DOC
#$TEXENGINE -synctex=1 -output-directory=$tmp_dir $OPTION_LATEX_VERBOSE $DOC
#$TEXENGINE -synctex=1 -output-directory=$tmp_dir $OPTION_LATEX_VERBOSE $DOC
#mv $FLAGS_MV $tmp_dir/"$(basename $DOCPDF)" $DOCPDF
#rm $FLAGS_RM -rf $tmp_dir
echo "[STATUS]: Latex documentation created."


#echo "[INFO]: Generating html documentation..."
#make4ht -a $OPTION_MK4_LOGLEVEL -d $BUILD_DIR/html -B $BUILD_DIR/html -c $ROOT/make4ht.cfg $DOC
#echo "[STATUS]: Html documentation created."
