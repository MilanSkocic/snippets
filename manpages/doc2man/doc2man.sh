#!/usr/bin/env bash

. configuration.sh

get_lang () {
    f=$1
    case ${f##*.} in
        "c")
            echo "C"
            ;;
        "f90")
            echo "Fortran"
            ;;
        "f")
            echo "Fortran77"
            ;;
        "py")
            echo "Python"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

list_sources () {
    for i in $SRC_DIR/*; do
        l=$(get_lang $i)
        echo "$i -> $l"
    done
}


list_sources
