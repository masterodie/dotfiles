#!/usr/bin/bash

help="Usage $0 [-hR]\n\n\tno argument\t\tCreate and apply patch-\n\t-R\t\t\tRevert patch\n\t-h\t\t\tthis help"

REVERT="0"
if [ "$1" == "-R" ]
then
    REVERT=$1
elif [ "$1" == "-h" ]
then
    echo -e "$help"
    exit 0
else
    # Create a patch file for rc.lua
    echo Creating update.patch
    diff -u rc.lua rc-test.lua > update.patch
fi

# Update rc.lua to be the same as rc-test.lua
if [ $REVERT == "-R" ]
then
    echo Reverting update
else
    echo Applying update
fi
patch $REVERT < update.patch
