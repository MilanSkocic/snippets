#!/usr/bin/env bash

help () {
    echo "NAME"
    echo "   program - Test arguments with getopts."
    echo ""
    echo "SYNOPSIS"
    echo "   program [OPTIONS] [OPTARGS] ARGS"
    
}

c_args=()

while getopts ":hb:c:" opt; do
    
    case ${opt} in
        c)
            c_args+=( "$OPTARG" )
		    #while [[ ${!OPTIND} && ${!OPTIND} != -* ]]; do
            #    c_args+=( "${!OPTIND}" )
			#((OPTIND++))
            #c_args+=( "${!OPTIND}" )
            #done
            ;;
        b)
            echo "b actiavted" 
            ;;
        h)
            help
            exit 0
            ;;
        :)
            echo $OPTARG "needs arguments"
            exit 1
            ;;
        ?)
            echo "Invalid"
            exit 1
            ;;
        *)
            echo $OPTARG
            ;;
    esac
done

echo "c_args: "${c_args[@]}

# Shift back to the argument after the final option has been parsed.
# Because getopts looks for one argument ahead as option argument
shift $((OPTIND-1))
echo $@
