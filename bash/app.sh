#!/usr/bin/env bash

# DEFINE
PROGNAME="program"
PROGVERSION="1.0"
SHORTDESCRIPTION="Short description"
HOMEPAGE="Home Page"
LICENSE="MIT"
MANSECTION="1"
RED="\e[31m"
BLACK="\e[0m"
GREEN="\e[32m"

# MENU FUNCTIONS
help () {
    echo "NAME"
    echo "    $PROGNAME($MANSECTION) - $SHORTDESCRIPTION"
    echo ""

    echo "SYNOPSIS"
    echo "    $PROGNAME SUBCOMMAND [SUBCOMMAND_OPTIONS]" 
    echo ""

    echo "DESCRIPTION"
    echo "   $PROGNAME is program that ..."
    echo ""
    
    echo "SUBCOMMANDS"
    echo -e $RED"+ build    Compile code."$BLACK
    echo ""
    
    echo "SUBCOMMANDS_OPTIONS"
    echo -e $GREEN" -d, --directory PATH    Set the working directory"$BLACK
    echo ""

    echo "EXAMPLES"
    echo "  $PROGNAME SUBCOMMAND COMMAND"
    echo ""
    
    echo "SEE ALSO"
    echo "  + The home page is ..."
    echo ""

}

help_usage () {
    echo "$PROGNAME:"
    echo ""
    echo "USAGE: $PROGNAME [SUBCOMMAND [SUBCOMMAND_OPTIONS]]|[--list|--help|--version]"
}

version () {
    echo "Version:      $PROGVERSION"
    echo "Program:      $PROGNAME"
    echo "Description:  $SHORTDESCRIPTION"
    echo "Home Page:    $HOMEPAGE"
    echo "License:      $LICENSE"
    echo "OS Type:      $OSTYPE"
}


case $1 in 
    "--help"|"-h")
        help
        ;;
    "--version"|"-v")
        version
        ;;
    *)
        help_usage
        ;;
esac
