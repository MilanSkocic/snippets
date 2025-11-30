#!/usr/bin/env bash
source ../make.in
TEX="build/latex/$NAME.tex"

header () {
    echo "\\documentclass{article}" > $1
    echo "\\begin{document}" >> $1
    echo "" >> $1
}

body () {
    IFS=$'\n'
    local content=$(cat build/latex/content.tex)
    for i in $content; do
        echo $i >> $1
    done
}

footer () {
    echo "" >> $1
    echo "\\end{document}" >> $1
}

header $TEX
body $TEX $CONTENT
footer $TEX
