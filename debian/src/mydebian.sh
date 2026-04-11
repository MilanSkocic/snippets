#!/usr/bin/env bash

# DEFINE
PROGNAME="mydebian"
PROGVERSION="0.6"
SHORTDESCRIPTION="Simple postinstaller for Debian."
HOMEPAGE=""
LICENSE="MIT"
MANSECTION="1"
RED="\e[31m"
BLACK="\e[0m"
GREEN="\e[32m"

CACHEDIR=$HOME/.cache/$PROGNAME

PYDEV="build-essential checkinstall autotools-dev make cmake
       libreadline-dev libncurses-dev libssl-dev libsqlite3-dev tk-dev
       libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev liblzma-dev
       libgdbm-compat-dev libnsl-dev
       python3-pip python3-setuptools"
GIT="git lazygit"
COMPILERS="gcc gfortran gcc-12 gfortran-12 gcc-13 gfortran-13 gcc-14 gfortran-14 
           npm golang valac"
NUMERIC="libopenblas0 libopenblas-dev libgsl-dev gsl-bin"
YARU="yaru-theme-gtk yaru-theme-icon"
UBUNTU="fonts-ubuntu fonts-ubuntu-console fonts-ubuntu-title"
TEX="texlive-full"
TOOLS="neovim neomutt calcurse kitty tmux tree pass doxygen
       stow btop htop fastfetch zoxide fzf tree pass gpg zsh
       graphviz imagemagick inkscape gimp dia geogebra
       help2man man2html txt2man"

DEB13="$PYDEV $GIT $COMPILERS $NUMERIC $YARU $UBUNTU $TOOLS"
DEB14="$DEB13 fortran-fpm"

FLAG_LIST=0
FLAG_VERBOSE=0

help () {
cat << EOT
NAME
  $PROGNAME - post installer for Debian.

SYNOPSIS
  $PROGNAME COMMAND [OPTIONS]" 

DESCRIPTION
  Simple post installer for Debian. The commands are defined as: 
    + 13                            Post installation for Debian 13 (trixie).
    + 14                            Post installation for Debian 14 (forky).
    + altgcc <version> <priority>   Add alternate for gcc or python.
    + altpy <version> <priority>    Add alternate for gcc or python.
    + pysrc <version>               Download python from python.org.

OPTIONS
  --list          List packages.
  --version, -v   Display version.
  --verbose, -V   Increase verbosity.
  --help, -h      Display help.

EXAMPLE
  Minimal example

    $PROGNAME 13" 
    $PROGNAME 13 --list" 
    $PROGNAME add altgcc 15 100
    $PROGNAME add altpy 3.14 100
    $PROGNAME pysrc 3.14.2

SEE ALSO
  apt(8)
EOT
}


version () {
cat << EOT
PROGRAM:      $PROGNAME                          
DESCRIPTION:  $SHORTDESCRIPTION                  
VERSION:      $PROGVERSION                       
AUTHOR:       M. Skocic                          
LICENSE:      $LICENSE                           
EOT
}

debianpackages () {
    # $1: debian version
    # $2: flag list
    # $3: flag verbose
    echo "Post install for debian $1..."
    local pkgs=""
    case $1 in 
        13)
            pkgs=$(printf "%s\n" $DEB13 | sort -t " ")
            ;;
        14)
            pkgs=$(printf "%s\n" $DEB14 | sort -t " ")
            ;;
        *)
            ;;
    esac
    if [[ $2 == 1 ]]; then 
        echo $(printf "%s\n" $pkgs | sort -t " "); 
        return 0; 
    fi
    if [[ $3 == 1 ]]; then
        sudo apt install -y $pkgs
    else
        sudo apt install -y $pkgs >/dev/null 2>&1
    fi
    if [[ $? != 0 ]]; then
        echo "Error occurred. Most likely, you required packages from the wrong Debian version."
        echo "Requested Debian version: $1."
        echo "You Debian version      : $(lsb_release -a | grep 'Release' | cut -d ":" -f 2 | sed -z 's/^[[:space:]]*//')."
    else
        echo "Done."
    fi
    return $?
}

add_gcc () {
    # $1: gcc version
    # $2: priority
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$1 $2 --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-$1 --slave /usr/bin/gcov gcov /usr/bin/gcov-$1
}

add_python () {
    sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python$1 $2 --slave /usr/bin/pip pip /usr/local/bin/pip$1
}

download_python () {
    mkdir -p $CACHEDIR
    if [[ ! -f $CACHEDIR/Python-$1.tgz ]]; then
        wget -P $CACHEDIR https://www.python.org/ftp/python/$1/Python-$1.tgz
    else
        echo "Python $1 has already been downloaded."
    fi
}

args=$*
for i in $args; do
    case $i in
        "--list")
            FLAG_LIST=1
            ;;
        "-V"|"--verbose")
            FLAG_VERBOSE=1
            ;;
        *)
            ;;
    esac
done

case $1 in
    "--help"|"-h")
        help 
        exit 0
        ;;
    "--version"|"-v")
        version
        exit 0
        ;;
    "13")
        debianpackages 13 $FLAG_LIST $FLAG_VERBOSE
        exit $?
        ;;
    "14")
        debianpackages 14 $FLAG_LIST $FLAG_VERBOSE
        exit $?
        ;;
    "altgcc")
        add_gcc $2 $3
        exit 0
        ;;
    "altpy")
        add_python $2 $3
        exit 0
        ;;
    "pysrc")
        download_python $2
        exit 0
        ;;
    *)
        help
        exit $?
        ;;
esac
