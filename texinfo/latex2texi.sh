#!/usr/bin/env bash
#set -x
lATEXFILE=$1
TEXIFILE="$(dirname $lATEXFILE)/$(basename -s .tex $lATEXFILE).texi"
IFS=$'\n'

convert () {
    line=$1
    # line=$(echo $line | sed -E 's/^ *//g' | sed -E 's/^\t//g')

    line=$(echo $line | sed -E 's/\\textbf/\@b/g')
    line=$(echo $line | sed -E 's/\\textit/\@i/g')
    line=$(echo $line | sed -E 's/\\emph/\@i/g')
    line=$(echo $line | sed -E 's/\\texttt/\@t/g')
    line=$(echo $line | sed -E 's/\\underline/\@i/g')
    
    math=$(echo $line | grep -o -P '(?<=\$).*(?=\$)')
    if [[ "${#math}" > 0 ]]; then
        echo "@c $line"
        return 1
    fi

    case $line in
        "\\chapter"*)
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\\chapter/\@chapter/g')
            echo $line
            ;;
        *"\\section"*)
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\\section/\@section/g')
            echo $line
            ;;
        "\\label"*)
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\\label/\@node/g')
            echo $line
            ;;
        *"\\begin{figure}"*|*"\\end{figure}"*)
            echo "@c $line"
            ;;
        *"\\centering"*)
            echo "@c $line"
            ;;
        *"\\includegraphics["*|*"\includegraphics["*)
            image=$(echo $line | grep -o -P '(?<=\{).*(?=\})')
            image=$(echo $image | cut -d '.' -f 1)
            echo "@image{$image,,,,.txt}"
            ;;
        *"\\caption"*)
            echo "@c $line"
            ;;
        *"\\label"*)
            echo "@c $line"
            ;;
        "\\"*)
            #cmd=$(echo $line | grep -o -P '(?<=\\).*(?={)')
            line=$(echo $line | sed -E 's/\\/\@/g')
            line=$(echo $line | sed -E 's/\{/ /g')
            line=$(echo $line | sed -E 's/\}/ /g')
            line=$(echo $line | sed -E 's/\@label/\@node/g')
            line=$(echo $line | sed -E 's/\\includegraphics/\@image/g')
            echo $line
            ;;
        *"\("*)
            line=$(echo $line | sed -E 's/\\\(/@math\{/g')
            line=$(echo $line | sed -E 's/\\\)/\}/g')
            echo $line
            ;;
        *)
            echo $line
            ;;
    esac
    
    return 0
}


echo "@c Autogeneraed $date" > $TEXIFILE



while read -r line; do
    l2=$(convert "$line")
    echo "[INFO]: $l2"
    echo $l2 >> $TEXIFILE
done < $lATEXFILE
