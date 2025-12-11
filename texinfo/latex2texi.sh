#!/usr/bin/env bash

lATEXFILE=$1
TEXIFILE="$(dirname $lATEXFILE)/$(basename -s .tex $lATEXFILE).texi"
IFS=$'\n'
convert () {
    l=$1

    echo $l
}


echo "@c Autogeneraed $date" > $TEXIFILE



while read -r line; do
    l2=$(convert "$line")
    echo $l2
done < $lATEXFILE
