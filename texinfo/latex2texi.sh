#!/usr/bin/env bash
set -x
lATEXFILE=$1
TEXIFILE="$(dirname $lATEXFILE)/$(basename -s .tex $lATEXFILE).texi"
IFS=$'\n'

convert () {
    line=$1
    line=$(echo $line | sed -E 's/^ *//g' | sed -E 's/^\t//g')

    case $line in
        "\\"*)
            cmd=$(echo $line | grep -o -P '(?<=\\).*(?={)')
            line=$(echo $line | sed -E 's/\\/\@/g')
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\@label/\@node/g')
            echo $line
            ;;
        *"$"*)
            math=$(echo $line | grep -o -P '\$.*?\$')
            f=$(echo $line | grep -o -P '(?<=\$).*(?=\$)')
            f="\@math\{$f\}"
            line=$(echo $line | sed -E "s:$math:$f:g")
            echo $line
            ;;
        *)
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\\tt//g')
            line=$(echo $line | sed -E 's/\\rm//g')
            line=$(echo $line | sed -E 's/\\bf//g')
            echo $line
            ;;
    esac
}


echo "@c Autogeneraed $date" > $TEXIFILE



while read -r line; do
    l2=$(convert "$line")
    echo $l2 >> $TEXIFILE
done < $lATEXFILE
