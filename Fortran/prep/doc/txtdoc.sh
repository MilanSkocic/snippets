#!/usr/bin/env bash

source ../make.in

TXT=$(ls build/man/*.txt)
DOC="build/txt/$NAME-documentation.txt"

echo "                     $NAME - DOCUMENTATION                              " > $DOC
echo "" >> $DOC

for i in $TXT; do

echo "------------------------------------------------------------------------" >> $DOC
cat $i >> $DOC
echo "------------------------------------------------------------------------" >> $DOC
echo "" >> $DOC
echo "" >> $DOC

done
