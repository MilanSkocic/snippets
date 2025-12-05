#!/usr/bin/env bash
source ../make.in

src=$1
out=$2

mkdir -p build/tmp

TMP=build/tmp/tmp.tex
TEX=build/tmp/$(basename -s .tex $2).pdf

echo "\\begin{verbatim}" > $2
man -l $1 >> $2
echo "\\end{verbatim}" >> $2
echo "" >> $2
echo "" >> $2
echo "" >> $2

title=$(basename $1)
author=$AUTHOR
content="$2"

cat tex/template_man.tex > $TMP
sed -E "s/<title>/$title/g" $TMP > $TEX
cat $TEX > $TMP
sed -E "s/<author>/$author/g" $TMP > $TEX
cat $TEX > $TMP
sed -E "s:<content>:$content:g" $TMP > $TEX

pdflatex -synctex=1 -output-directory=build/tmp $TEX

mv $TEX $(dirname $2)

rm -rfv build/tmp
