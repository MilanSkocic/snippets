#!/usr/bin/env bash

# DEFINE
PROGNAME="program"
PROGVERSION="1.0"
SHORTDESCRIPTION="Short description"
HOMEPAGE="Home Page"
LICENSE="MIT"
MANSECTION="1"

# MENU FUNCTIONS
help () {
    echo "Usage: $PROGNAME COMMAND [SUBCOMMAND_OPTIONS]" 
    echo "\`$PROGNAME\` -- $SHORTDESCRIPTION"
    echo ""

    echo "Options:"
    echo "  -v, --version   Display version."
    echo "  -h, --help      Display help."
    echo ""
    
    echo "*Commands*"
    echo "  CMD [OPTIONS]            Command."
    echo ""
    
    echo "*Subcommand options*"
    echo "  --list                   List something."
    echo ""

    echo "Examples:"
    echo "  $PROGNAME 13             Example 1." 

    echo "Report bugs to <john.doe@mail.com>"
}

version () {
    echo "$PROGNAME $PROGVERSION"
    echo ""
    echo "Copyright (c) 20XX J. Doe."
    echo "MIT License."
    echo ""
    echo "Written by J. Doe."
}


case $1 in 
    "--help"|"-h")
        help
        exit 0
        ;;
    "--version"|"-v")
        version
        exit 0
        ;;
    *)
        help
        ;;
esac
